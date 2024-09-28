import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lecsens/viewModel/user_view_model.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/repository/home_repository.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/data/response/query_response.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/data/db/lecsens_database.dart';
import 'package:lecsens/models/user_model.dart';
import 'package:lecsens/data/response/status.dart';
import 'package:lecsens/res/chart_data.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();
  bool _logoutLoading = false;
  bool _fetchingData = false;
  
  final String _macAddress = '00:00:00:00:00:00';
  String _title = '';
  LecsensData? _newestLecsensData;
  LecsensData? _newestLecsensDataByDate;
  List<ChartData>? _chartData;
  List<LecsensData>? _lecsensDataByDateList;

  QueryResponse<LecsensDataList> lecsensDataList = QueryResponse.loading();

  get logoutLoading => _logoutLoading;
  get fetchingData => _fetchingData;
  get title => _title;
  get chartData => _chartData;
  get latestLecsensData => _newestLecsensData;
  get latestLecsensDataByDate => _newestLecsensDataByDate;
  get lecsensDataByDateList => _lecsensDataByDateList;

  setLecsensDataList(QueryResponse<LecsensDataList> response) {
    lecsensDataList = response;

    if (response.status == Status.completed && response.data != null && response.data!.lecsensDataList.isNotEmpty) {
      _newestLecsensData = response.data!.getLatestData();
    } else {
      _newestLecsensData = null;
    }

    if (_newestLecsensData != null) {
      _chartData = Utils.getConvertedVoltametryData(_newestLecsensData!);
    } else {
      _chartData = null;
    }

    notifyListeners();
  }

  setLecsensDataByDateList(QueryResponse<LecsensDataList> response) {
    lecsensDataList = response;

    if (response.status == Status.completed && response.data != null && response.data!.lecsensDataList.isNotEmpty) {
      _newestLecsensDataByDate = response.data!.getLatestData();
    } else {
      _newestLecsensDataByDate = null;
    }

    if (_newestLecsensDataByDate != null) {
      _chartData = Utils.getConvertedVoltametryData(_newestLecsensDataByDate!);
    } else {
      _chartData = null;
    }

    notifyListeners();
  }

  void setLogoutLoading(bool value) {
    _logoutLoading = value;
    notifyListeners();
  }

  void setFetchingData(bool value) {
    _fetchingData = value;
    notifyListeners();
  }

  void setLecsensDataByDateListQuery(BuildContext context, String date) async {
    setLecsensDataByDateList(QueryResponse.loading());
    final userViewModel = UserViewModel();
    final user = await userViewModel.getCurrentUser();

    if (user != null) {
      setFetchingData(true);
      _homeRepository.fetchAllLecsensDataByDate(_macAddress, date).then((value) {
        setFetchingData(false);
        try {
          final lecsensDataList = value;
          setLecsensDataByDateList(QueryResponse.completed(value));
          // Utils.showSnackBar(context, 'Data fetched successfully');
        } catch (e) {
          Utils.showSnackBar(context, 'Failed to parse lecsens data.');
          setLecsensDataByDateList(QueryResponse.error('Failed to parse lecsens data.'));
        }
      }).onError((error, stackTrace) {
        setFetchingData(false);
        Utils.showSnackBar(context, error.toString());
        setLecsensDataByDateList(QueryResponse.error(error.toString()));
      });
    }
  }

  Future<void>resyncData(BuildContext context) async {
    final userViewModel = UserViewModel();
    final user = await userViewModel.getCurrentUser();
    final last_sync_time = await userViewModel.getLastSyncTime();

    if (user != null) {
      Utils().syncDatabase(context, user, last_sync_time);
    }
  }

  void setLecsensDataListQuery(BuildContext context) async {
    setLecsensDataList(QueryResponse.loading());
    final userViewModel = UserViewModel();
    final user = await userViewModel.getCurrentUser();

    if (user != null) {
      setFetchingData(true);
      _homeRepository.fetchAllLecsensData().then((value) {
        setFetchingData(false);
        try {
          final lecsensDataList = value;
          setLecsensDataList(QueryResponse.completed(value));
          // Utils.showSnackBar(context, 'Data fetched successfully');
        } catch (e) {
          Utils.showSnackBar(context, 'Failed to parse lecsens data.');
          setLecsensDataList(QueryResponse.error('Failed to parse lecsens data.'));
        }
      }).onError((error, stackTrace) {
        setFetchingData(false);
        Utils.showSnackBar(context, error.toString());
        setLecsensDataList(QueryResponse.error(error.toString()));
      });
    }
  }

  void manualSync(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    User? user = await userPreference.getCurrentUser();

    if (user != null) {
      setFetchingData(true);
      Utils().syncDatabase(context, user, userPreference.getLastSyncTime().toString());
      setFetchingData(false);
      Utils.showSnackBar(context, 'Data synced successfully');
    } else {
      Utils.showSnackBar(context, 'User not found');
    }
  }

  void setTitle() async {
    final userViewModel = UserViewModel();
    final user = await userViewModel.getCurrentUser();

    if (user != null && user.fullName != null) {
      String firstName = user.fullName!.split(' ')[0];
      _title = 'Halo, $firstName';
      notifyListeners();
    } else {
      _title = 'Halo';
      notifyListeners();
    }
  }

  Future<void> logout(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    User? user = await userPreference.getCurrentUser();

    if (user != null) {
      Utils().dropAllData(context, user);
      userPreference.removeUser();
      Navigator.pushNamed(context, RouteNames.login);
    } else {
      Utils.showSnackBar(context, 'User not found');
    }
  }
}

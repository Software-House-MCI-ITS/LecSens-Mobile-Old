import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:lecsens/viewModel/user_view_model.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/repository/home_repository.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/data/response/api_response.dart';
import 'package:lecsens/models/lecsens_data_model.dart';

class HomeViewModel with ChangeNotifier {
  final _homeRepository = HomeRepository();

  ApiResponse<LecsensList> lecsensDataList = ApiResponse.loading();
  bool _logoutLoading = false;
  bool _fetchingData = false;

  get logoutLoading => _logoutLoading;
  get fetchingData => _fetchingData;

  setLecsensList(ApiResponse<LecsensList> response) {
    lecsensDataList = response;
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

  Future<void> logout(BuildContext context) async {
    final userPreference = Provider.of<UserViewModel>(context, listen: false);
    userPreference.removeUser();
    Navigator.pushNamed(context, RouteNames.login);
  }

  void fetchLecsensListApi(BuildContext context) async {
    setLecsensList(ApiResponse.loading());
    final userViewModel = UserViewModel();
    final user = await userViewModel.getUser();

    if (user != null) {
      setFetchingData(true);
      _homeRepository.fetchLecsensDataByUserID(user.token!).then((value) {
        setFetchingData(false);
        if (value['message'] == 'success') {
          final lecsensList = LecsensList.fromJson(value);
          setLecsensList(ApiResponse.completed(lecsensList));
        } else {
          Utils.showSnackBar(context, value['message']);
          setLecsensList(ApiResponse.error(value['message']));
        }
      }).onError((error, stackTrace) {
        setFetchingData(false);
        Utils.showSnackBar(context, error.toString());
        setLecsensList(ApiResponse.error(error.toString()));
      });
    }
  }
}

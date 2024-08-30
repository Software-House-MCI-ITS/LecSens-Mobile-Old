import 'package:flutter/cupertino.dart';
import 'package:lecsens/data/response/status.dart';
import 'package:lecsens/data/response/api_response.dart';
import 'package:lecsens/repository/riwayat_repository.dart';
import 'package:lecsens/models/voltametry_data_model.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/viewModel/user_view_model.dart';

class RiwayatViewModel with ChangeNotifier {
  final _riwayatRepository = RiwayatRepository();
  bool _fetchingData = false;
  final String _macAddress = '00:00:00:00:00:00';
  ApiResponse<VoltametryDataList> voltametryDataListResponse = ApiResponse.loading();
  List<VoltametryData> _voltametryDataList = <VoltametryData>[];

  get fetchingData => _fetchingData;
  get dataList => _voltametryDataList;

  void setFetchingData(bool value) {
    _fetchingData = value;
    notifyListeners();
  }

  void filterVoltametryDataList(String filter) {
    switch (filter) {
      case 'Arsen':
        _voltametryDataList = voltametryDataListResponse.data!.getArsenData();
      case 'Kadmium':
        _voltametryDataList = voltametryDataListResponse.data!.getKadmiumData();
      case 'Merkuri':
        _voltametryDataList = voltametryDataListResponse.data!.getMerkuriData();
      case 'Timbal':
        _voltametryDataList = voltametryDataListResponse.data!.getTimbalData();
      case 'Mikroplastik':
        _voltametryDataList = voltametryDataListResponse.data!.getMikroplastikData();
      default:
        _voltametryDataList = voltametryDataListResponse.data!.voltametryDataList;
    }
    notifyListeners();
  }

  void setVoltametryDataList(ApiResponse<VoltametryDataList> response) {
    voltametryDataListResponse = response;
    notifyListeners();
  }

  void setVoltametryDataListApi(BuildContext context, String filter) async {
    setVoltametryDataList(ApiResponse.loading());
    final userViewModel = UserViewModel();
    final user = await userViewModel.getCurrentUser();

    if (user != null) {
      setFetchingData(true);
      _riwayatRepository.fetchVoltametryDataByAlat(user.token, _macAddress).then((value) {
        setFetchingData(false);
        try {
          final voltametryList = VoltametryDataList.fromJson(value);
          setVoltametryDataList(ApiResponse.completed(voltametryList));
          filterVoltametryDataList(filter);
        } catch (e) {
          Utils.showSnackBar(context, 'Failed to parse voltametry data.');
          setVoltametryDataList(ApiResponse.error('Failed to parse voltametry data.'));
        }
      }).onError((error, stackTrace) {
        setFetchingData(false);
        Utils.showSnackBar(context, error.toString());
        setVoltametryDataList(ApiResponse.error(error.toString()));
      });
    }
  }
}

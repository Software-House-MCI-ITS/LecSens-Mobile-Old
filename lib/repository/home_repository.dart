import 'package:lecsens/data/network/network_api_services.dart';
import 'package:lecsens/res/widgets/app_urls.dart';
import 'package:lecsens/utils/utils.dart';

class HomeRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<dynamic> fetchLecsensDataByUserID(String token) async {
    try {
      final response = await _network.getGetApiResponse(AppUrls.lecsensDataByUserIDEndpoint, token);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<dynamic> fetchVoltametryDataByAlat(String token, String macAddress) async {
    final String formattedMacAddress = Utils.getFormattedMacAddress(macAddress);

    try {
      final response = await _network.getGetApiResponse(AppUrls.voltametryDataByAlatEndpoint + formattedMacAddress, token);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}

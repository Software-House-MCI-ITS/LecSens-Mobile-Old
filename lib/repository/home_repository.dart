import 'package:lecsens/data/network/network_api_services.dart';
import 'package:lecsens/res/widgets/app_urls.dart';

class HomeRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<dynamic> fetchLecsensDataByUserID(String token) async {
    try {
      final response = await _network.getGetApiResponse(AppUrls.getLecsensDataByUserIDEndpoint, token);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}

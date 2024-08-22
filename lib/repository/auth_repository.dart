import 'dart:convert';
import 'package:lecsens/data/network/network_api_services.dart';
import 'package:lecsens/res/widgets/app_urls.dart';

class AuthRepository {
  final NetworkApiServices _network = NetworkApiServices();

  Future<dynamic> login(dynamic data) async {
    dynamic requestjson = jsonEncode(data);
    try {
      final response = await _network.getPostApiResponse(AppUrls.loginEndPoint, requestjson);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }


  Future<dynamic> signUp(dynamic data) async {
    dynamic requestjson = jsonEncode(data);
    try {
      final response =
          await _network.getPostApiResponse(AppUrls.registerEndPoint, requestjson);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<dynamic> sendVerificationEmail(dynamic email) async {
    dynamic data = {'email': email};
    dynamic requestjson = jsonEncode(data);
    try {
      final response = await _network.getPostApiResponse(AppUrls.emailVerificationEndpoint, requestjson);
      return response;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}

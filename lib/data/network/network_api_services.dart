import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:lecsens/data/app_exceptions.dart';
import 'package:lecsens/data/network/base_api_services.dart';

class NetworkApiServices extends BaseApiServices {
  @override
  Future getGetApiResponse(String url, String token) async {
    dynamic responsejson;
    try {
      final response =
          await http.get(
            Uri.parse(url),
            headers: {
              'Authorization': token
            }
          ).timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  @override
  Future getPostApiResponse(String url, dynamic data) async {
    dynamic responsejson;
    try {
      final response = await http
          .post(Uri.parse(url),
            headers: {
              'Content-Type': 'application/json',
            },
            body: data)
          .timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  @override
  Future getPutApiResponse(String url, dynamic data) async {
    dynamic responsejson;
    try {
      final response = await http
          .put(Uri.parse(url), body: data)
          .timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  @override
  Future getDeleteApiResponse(String url) async {
    dynamic responsejson;
    try {
      final response =
        await http.delete(Uri.parse(url)).timeout(const Duration(seconds: 10));
      responsejson = responseJson(response);
    } on SocketException {
      throw InternetException("NO Internet is available right now");
    }

    return responsejson;
  }

  dynamic responseJson(http.Response response) {
    switch (response.statusCode) {
      case 200:
        dynamic jsonResponse = jsonDecode(response.body);
        dynamic data = jsonResponse['data'];
        return data;
      case 400:
        dynamic data = jsonDecode(response.body);
        throw BadRequestException(data['message']);
      case 417:
        dynamic data = jsonDecode(response.body);
        return data;
      default:
        throw InternetException("${response.statusCode} : ${response.reasonPhrase}");
    }
  }
}

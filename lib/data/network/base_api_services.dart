abstract class BaseApiServices {
  Future<dynamic> getGetApiResponse(String url, String token);
  Future<dynamic> getPostApiResponse(String url, dynamic data);
  Future<dynamic> getPutApiResponse(String url, dynamic data);
  Future<dynamic> getDeleteApiResponse(String url);
}

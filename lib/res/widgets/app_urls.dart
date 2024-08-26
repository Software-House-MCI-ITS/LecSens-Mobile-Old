class AppUrls {
  static const baseUrl = "http://195.35.6.208:8080";
  static const loginEndPoint = "$baseUrl/users/login";
  static const registerEndPoint = "$baseUrl/users/register";
  static const emailVerificationEndpoint = "$baseUrl/users/verification-email";
  static const lecsensDataByUserIDEndpoint = "$baseUrl/lecsens-data/get-all";
  static const voltametryDataByAlatEndpoint = "$baseUrl/lecsens-data/get-lecsens-data?mac_address=";
  static const voltametryDataGroupedEndpoint = "$baseUrl/lecsens-data/get-lecsens-data-label?mac_address=";
}

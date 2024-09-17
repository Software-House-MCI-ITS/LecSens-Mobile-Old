class AppUrls {
  static const baseUrl = "http://195.35.6.208:8080";
  static const loginEndPoint = "$baseUrl/users/login";
  static const registerEndPoint = "$baseUrl/users/register";
  static const emailVerificationEndpoint = "$baseUrl/users/verification-email";
  static const allLecsensData = "$baseUrl/lecsens-data/get-all?last_sync_time=";
  static const voltametryDataByAlatEndpoint = "$baseUrl/lecsens-data/get-lecsens-data?mac_address=";
  static const allAlatEndpoint = "$baseUrl/alat/get-all?last_sync_time=";
  static const allAlatUpdatedEndpoint = "$baseUrl/alat/get-all-updated?last_sync_time=";
  static const allLecsensDataUpdatedEndpoint = "$baseUrl/lecsens-data/get-all-updated?last_sync_time=";
}

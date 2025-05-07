class AppUrls {
  static const baseUrl = "https://lecsens-api.erplabiim.com";
  static const loginEndPoint = "$baseUrl/users/login";
  static const registerEndPoint = "$baseUrl/users/register";
  static const emailVerificationEndpoint = "$baseUrl/users/verification-email";
  static const allLecsensData = "$baseUrl/lecsens-data/get-all?last_sync_time=";
  static const voltametryDataByAlatEndpoint = "$baseUrl/lecsens-data/get-lecsens-data?mac_address=";
  static const allAlatEndpoint = "$baseUrl/alat/get-all?last_sync_time=";
  static const allAlatUpdatedEndpoint = "$baseUrl/access";
  static const allLecsensDataUpdatedEndpoint = "$baseUrl/lecsens-data/get-all?date=";
}

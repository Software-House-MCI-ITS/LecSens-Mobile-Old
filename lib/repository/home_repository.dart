import 'package:lecsens/data/db/lecsens_database.dart';
import 'package:lecsens/res/widgets/app_urls.dart';
import 'package:lecsens/utils/utils.dart';

class HomeRepository {
  Future<dynamic> fetchAllLecsensData(String macAddress) async {
    final String formattedMacAddress = Utils.getFormattedMacAddress(macAddress);

    try {
      final allLecsensData = await LecSensDatabase.instance.getAllLecsensData();
      return allLecsensData;
    } catch (e) {
      rethrow; //Big Brain
    }
  }

  Future<dynamic> fetchAllLecsensDataByDate(String macAddress, String date) async {
    final String formattedMacAddress = Utils.getFormattedMacAddress(macAddress);

    try {
      final allLecsensDataByDate = await LecSensDatabase.instance.getAllLecsensDataByDate(date);
      return allLecsensDataByDate;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}

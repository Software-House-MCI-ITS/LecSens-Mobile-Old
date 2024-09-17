import 'package:lecsens/data/db/lecsens_database.dart';
import 'package:lecsens/res/widgets/app_urls.dart';
import 'package:lecsens/utils/utils.dart';

class RiwayatRepository {
  Future<dynamic> fetchAllLecsensData(String macAddress, int page, String label) async {
    final String formattedMacAddress = Utils.getFormattedMacAddress(macAddress);

    try {
      final allLecsensData = await LecSensDatabase.instance.getAllLecsensDataByLabelPagination(page, label);
      return allLecsensData;
    } catch (e) {
      rethrow; //Big Brain
    }
  }
}

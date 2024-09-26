import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:lecsens/models/alat_model.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/res/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:lecsens/data/network/network_api_services.dart';
import 'package:lecsens/res/widgets/app_urls.dart';
import 'package:lecsens/models/user_model.dart';
import 'package:lecsens/data/db/lecsens_database.dart';

class Utils {
  static void showSnackBar(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void launchUrl(BuildContext context, String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      Utils.showSnackBar(context, 'Could not launch $url');
    }
  }

  static void mailClientLaunch(BuildContext context) async {
    final Uri emailUri = Uri(
      scheme: 'mailto',
      path: 'hanunshaka02@gmail.com',
      query: 'subject=Butuh Bantuan LecSens&body=Halo, saya butuh bantuan terkait aplikasi LecSens',
    );

    if (await canLaunch(emailUri.toString())) {
      await launch(emailUri.toString());
    } else {
      Utils.showSnackBar(context, 'Could not launch email client');
    }
  }

  static void uploadData(BuildContext context, String data) async {
    Utils.showSnackBar(context, 'Uploading data ...');
    await Future.delayed(const Duration(seconds: 3));
    Utils.showSnackBar(context, 'Data uploaded successfully');
    Navigator.pushNamed(context, RouteNames.home);
  }

  static void changeNodeFocus(BuildContext context,
      {FocusNode? current, FocusNode? next}) {
    current!.unfocus();
    FocusScope.of(context).requestFocus(next);
  }

  static String getFormattedMacAddress(String macAddress) {
    return macAddress.replaceAll(':', '%3A');
  }

  static List<ChartData> getConvertedVoltametryData(LecsensData data) {
    List<double> dataX = data.data_x;
    List<double> dataY = data.data_y;
    List<ChartData> chartData = [];

    for (int i = 0; i < dataX.length; i++) {
      chartData.add(ChartData(dataX[i], dataY[i], Colors.red));
    }

    return chartData;
  }

  static List<ChartData> getConvertedPpmData(List<LecsensData> data) {
    List<ChartData> chartData = [];

    for (int i = 0; i < data.length; i++) {
      chartData.add(ChartData(i + 1, data[i].ppm.toDouble(), Colors.blue));
    }

    return chartData;
  }

  String getFormattedDate(String date, int length) {
    return date.substring(0, length);
  }

  void showAlert(BuildContext context, String title, String content) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: <Widget>[
            TextButton(
              child: const Text("OK"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  String formatTime(String time) {
    String formattedTime = time.substring(0, 19).replaceAll(' ', '%20');
    return formattedTime;
  }

  Future<bool> syncDatabase(BuildContext context, User user, String last_sync_time) async {
    Utils.showSnackBar(context, 'Syncing database ...');
    final NetworkApiServices _network = NetworkApiServices();

    try {
      // bulk insert lecsens data
      String lecsens_data_updated_url = AppUrls.allLecsensDataUpdatedEndpoint + formatTime(last_sync_time);
      final responseLecsensDataUpdated = await _network.getGetApiResponse(lecsens_data_updated_url, user.token);

      if (responseLecsensDataUpdated != null) {
        final lecsensDataUpdated = responseLecsensDataUpdated.map((data) => LecsensData.fromJson(data)).toList().cast<LecsensData>();
        await LecSensDatabase.instance.bulkInsertLecsensData(lecsensDataUpdated);
      }

      // bulk insert access
      String access_data_updated_url = AppUrls.allAlatUpdatedEndpoint;
      final responseAccessDataUpdated = await _network.getGetApiResponse(access_data_updated_url, user.token);

      if (responseAccessDataUpdated != null) {
        final accessDataUpdated = responseAccessDataUpdated.map((data) => Alat.fromJson(data)).toList().cast<Alat>();
        await LecSensDatabase.instance.bulkInsertAlat(accessDataUpdated);
      }

      Utils.showSnackBar(context, 'Database synced successfully');
      return true;
    } catch (e) {
      print('Error in syncing database: $e');
      Utils.showSnackBar(context, 'Failed to sync alat data, retry later');
      return false;
    }
  }

  Future<bool> dropAllData(BuildContext context, User user) async {
    Utils.showSnackBar(context, 'Dropping all data ...');
    await LecSensDatabase.instance.deleteAllAlat();
    await LecSensDatabase.instance.deleteAllLecsensData();
    Utils.showSnackBar(context, 'All data dropped successfully');
    return true;
  }
}

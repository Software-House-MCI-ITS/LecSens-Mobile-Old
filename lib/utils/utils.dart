import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
    List<double> peakX = data.peak_x;
    List<ChartData> chartData = [];

    for (int i = 0; i < dataX.length; i++) {
      if ((dataX[i] < peakX[0] + 5 && dataX[i] > peakX[0] - 5) || (dataX[i] > peakX[1] + 5 && dataX[i] > peakX[1] - 5)) {
        chartData.add(ChartData(dataX[i], dataY[i], Colors.red));
      } else {
        chartData.add(ChartData(dataX[i], dataY[i], Colors.blue));
      }
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

  Future<bool> syncDatabase(BuildContext context, User user, String last_sync_time) async {
    Utils.showSnackBar(context, 'Syncing database ...');
    final NetworkApiServices _network = NetworkApiServices();

    try {
      // alat
      String alat_url = AppUrls.allAlatEndpoint + last_sync_time;
      final responseAlat = await _network.getGetApiResponse(alat_url, user.token);
      if (responseAlat != null) {
        await LecSensDatabase.instance.bulkInsertAlat(responseAlat);
      }

      String alat_updated_url = AppUrls.allAlatUpdatedEndpoint + last_sync_time;
      final responseAlatUpdated = await _network.getGetApiResponse(alat_updated_url, user.token);
      if (responseAlatUpdated != null) {
        await LecSensDatabase.instance.bulkUpdateAlat(responseAlatUpdated);
      }

      // lecsens data
      String lecsens_data_url = AppUrls.allLecsensData + last_sync_time;
      final responseLecsensData = await _network.getGetApiResponse(lecsens_data_url, user.token);
      if (responseLecsensData != null) {
        await LecSensDatabase.instance.bulkInsertLecsensData(responseLecsensData);
      }

      String lecsens_data_updated_url = AppUrls.allLecsensDataUpdatedEndpoint + last_sync_time;
      final responseLecsensDataUpdated = await _network.getGetApiResponse(lecsens_data_updated_url, user.token);
      if (responseLecsensDataUpdated != null) {
        await LecSensDatabase.instance.bulkUpdateLecsensData(responseLecsensDataUpdated);
      }

      Utils.showSnackBar(context, 'Database synced successfully');
      return true;
    } catch (e) {
      Utils.showSnackBar(context, 'Failed to sync alat data');
      return false;
    }
  }

  Future<bool> dropAllData(BuildContext context, User user) async {
    Utils.showSnackBar(context, 'Dropping all data ...');
    await LecSensDatabase.instance.deleteAllAlat();
    await LecSensDatabase.instance.deleteAllLecsensData();
    await LecSensDatabase.instance.removeUser(user);
    Utils.showSnackBar(context, 'All data dropped successfully');
    return true;
  }
}

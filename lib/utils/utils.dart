import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/models/voltametry_data_model.dart';
import 'package:lecsens/res/chart_data.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

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

  static List<ChartData> getConvertedVoltametryData(VoltametryData data) {
    List<double> dataX = data.data_x;
    List<double> dataY = data.data_y;
    List<double> peakX = data.peak_x;
    List<ChartData> chartData = [];

    for (int i = 0; i < dataX.length; i++) {
      if ((dataX[i] > peakX[0] + 10 || dataX[i] > peakX[0] - 10) || (dataX[i] > peakX[1] + 10 || dataX[i] > peakX[1] - 10)) {
        chartData.add(ChartData(dataX[i], dataY[i], Colors.red));
      } else {
        chartData.add(ChartData(dataX[i], dataY[i], Colors.blue));
      }
    }

    return chartData;
  }

  static List<ChartData> getConvertedPpmData(List<VoltametryData> data) {
    List<ChartData> chartData = [];

    for (int i = 0; i < data.length; i++) {
      chartData.add(ChartData(i + 1, data[i].ppm.toDouble(), Colors.blue));
    }

    return chartData;
  }

  String getFormattedDate(String date, int length) {
    return date.substring(0, length);
  }
}

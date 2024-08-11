import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    await Future.delayed(const Duration(seconds: 3));
    Navigator.pushNamed(context, RouteNames.login);
  }
}

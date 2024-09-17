import 'package:flutter/material.dart';
import 'package:lecsens/models/lecsens_data_model.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/view/home_screen.dart';
import 'package:lecsens/view/login_screen.dart';
import 'package:lecsens/view/splash_screen.dart';
import 'package:lecsens/view/signup_screen.dart';
import 'package:lecsens/view/share_location_screen.dart';
import 'package:lecsens/view/detail_screen.dart';
import 'package:lecsens/view/verifikasi_email_screen.dart';
import 'package:lecsens/view/riwayat_screen.dart';

class Routes {
  static Route<dynamic> generateRoutes(RouteSettings settings) {
    switch (settings.name) {
      case (RouteNames.home):
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case (RouteNames.login):
        return MaterialPageRoute(
            builder: (BuildContext context) => const LoginScreen());
      case (RouteNames.signup):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SignupScreen());
      case (RouteNames.splash):
        return MaterialPageRoute(
            builder: (BuildContext context) => const SplashScreen());
      case (RouteNames.ambilData):
        return MaterialPageRoute(
            builder: (BuildContext context) => const ShareLocationScreen());
      case (RouteNames.detail):
        final args = settings.arguments as LecsensData;
        return MaterialPageRoute(
            builder: (BuildContext context) => DetailScreen(voltametryData: args));
      case (RouteNames.emailVerification):
        return MaterialPageRoute(
            builder: (BuildContext context) => const VerifikasiEmailScreen());
      case (RouteNames.riwayat):
        final args = settings.arguments as String;
        return MaterialPageRoute(
            builder: (BuildContext context) => RiwayatScreen(text: args));
      default:
        return MaterialPageRoute(
          builder: (_) => const Scaffold(
            body: Center(
              child: Text("No route is configured"),
            ),
          ),
        );
    }
  }
}

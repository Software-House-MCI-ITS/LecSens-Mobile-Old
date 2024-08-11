import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/view/home_screen.dart';
import 'package:lecsens/view/login_screen.dart';
import 'package:lecsens/view/splash_screen.dart';
import 'package:lecsens/view/signup_screen.dart';
import 'package:lecsens/view/ambil_data_screen.dart';
import 'package:lecsens/view/detail_screen.dart';
import 'package:lecsens/view/verifikasi_email_screen.dart';

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
            builder: (BuildContext context) => const AmbilDataScreen());
      case (RouteNames.detail):
        return MaterialPageRoute(
            builder: (BuildContext context) => const DetailScreen());
      case (RouteNames.emailVerification):
        return MaterialPageRoute(
            builder: (BuildContext context) => const VerifikasiEmailScreen());
      
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

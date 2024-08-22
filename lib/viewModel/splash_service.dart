import 'package:flutter/material.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/viewModel/user_view_model.dart';

class SplashService {
  static void checkAuthentication(BuildContext context) async {
    final userViewModel = UserViewModel();
    final user = await userViewModel.getCurrentUser();

    if (user == null) {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.login);
    } else {
      await Future.delayed(const Duration(seconds: 3));
      Navigator.pushNamed(context, RouteNames.home);
    }
  }
}

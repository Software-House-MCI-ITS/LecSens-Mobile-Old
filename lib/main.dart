import 'package:flutter/material.dart';
import 'package:lecsens/viewModel/riwayat_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/utils/routes/routes.dart';

import 'package:lecsens/viewModel/home_view_model.dart';
import 'package:lecsens/viewModel/auth_view_model.dart';
import 'package:lecsens/viewModel/user_view_model.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthViewModel()),
        ChangeNotifierProvider(create: (_) => UserViewModel()),
        ChangeNotifierProvider(create: (_) => HomeViewModel()),
        ChangeNotifierProvider(create: (_) => RiwayatViewModel())
      ],
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return true;
        },
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            primarySwatch: Colors.blue,
          ),
          initialRoute: RouteNames.splash,
          onGenerateRoute: Routes.generateRoutes,
        ),
      ),
    );
  }
}

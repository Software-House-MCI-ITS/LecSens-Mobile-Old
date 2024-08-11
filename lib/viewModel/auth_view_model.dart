import 'package:flutter/material.dart';
import 'package:lecsens/repository/auth_repository.dart';
import 'package:lecsens/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/models/user_model.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loginLoading = false;
  bool _signUpLoading = false;

  get loginLoading => _loginLoading;
  get signUpLoading => _signUpLoading;

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  Future<void> login(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    _auth.apiLogin(data).then((value) {
      final userPreference = Provider.of<UserViewModel>(context, listen: false);

      User user = User.fromJson(value);
      userPreference.saveCurrentUser(user);

      Utils.showSnackBar(context, "Login success");
      setLoginLoading(false);

      Navigator.pushNamed(context, RouteNames.home);
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context, error.toString());
      setLoginLoading(false);
    });
  }

  Future<void> apiSignUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _auth.signUp(data).then((value) {
      Utils.showSnackBar(context, "Sign up success");

      Navigator.pushNamed(context, RouteNames.home);
      setSignUpLoading(false);
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context, error.toString());
      setSignUpLoading(false);
    });
  }
}
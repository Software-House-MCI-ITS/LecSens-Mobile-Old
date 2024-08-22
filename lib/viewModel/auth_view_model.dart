import 'package:flutter/material.dart';
import 'package:lecsens/repository/auth_repository.dart';
import 'package:lecsens/viewModel/user_view_model.dart';
import 'package:provider/provider.dart';
import 'package:lecsens/utils/utils.dart';
import 'package:lecsens/utils/routes/routes_names.dart';
import 'package:lecsens/models/user_model.dart';
import 'package:lecsens/data/db/lecsens_database.dart';

class AuthViewModel with ChangeNotifier {
  final _auth = AuthRepository();

  bool _loginLoading = false;
  bool _signUpLoading = false;
  bool _sendingVerificationEmail = false;

  get loginLoading => _loginLoading;
  get signUpLoading => _signUpLoading;
  get sendingVerificationEmail => _sendingVerificationEmail;

  void setLoginLoading(bool value) {
    _loginLoading = value;
    notifyListeners();
  }

  void setSignUpLoading(bool value) {
    _signUpLoading = value;
    notifyListeners();
  }

  void setSendingVerificationEmail(bool value) {
    _sendingVerificationEmail = value;
    notifyListeners();
  }

  Future<void> login(dynamic data, BuildContext context) async {
    setLoginLoading(true);
    _auth.login(data).then((value) {
      if (value['message'] == 'pengguna belum diverifikasi') {
        setLoginLoading(false);
        Navigator.pushNamed(context, RouteNames.emailVerification);
      } else {
        final userPreference = Provider.of<UserViewModel>(context, listen: false);

        User user = User.fromJson(value);
        userPreference.saveCurrentUser(user);
        LecSensDatabase.instance.insertUser(user);

        Utils.showSnackBar(context, "Login success");
        setLoginLoading(false);
        Navigator.pushNamed(context, RouteNames.home);
      }
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context, error.toString());
      setLoginLoading(false);
    });
  }

  Future<void> signUp(dynamic data, BuildContext context) async {
    setSignUpLoading(true);
    _auth.signUp(data).then((value) {
      Utils.showSnackBar(context, "Sign up success");
      Navigator.pushNamed(context, RouteNames.login);
      setSignUpLoading(false);
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context, error.toString());
      setSignUpLoading(false);
    });
  }

  Future<void> sendVerificationEmail(String email, BuildContext context) async {
    setSendingVerificationEmail(true);
    _auth.sendVerificationEmail(email).then((value) {
      setSendingVerificationEmail(false);
    }).onError((error, stackTrace) {
      Utils.showSnackBar(context, error.toString());
      setSendingVerificationEmail(false);
    });
  }
}

import 'package:flutter/material.dart';
import 'package:lecsens/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveCurrentUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();
    sp.setString('token', user.token.toString());
    sp.setString('user_id', user.id.toString());
    sp.setString('user_name', user.fullName.toString());
    notifyListeners();

    return true;
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("token");
    sp.remove("user_id");
    sp.remove("user_name");
    notifyListeners();
    return true;
  }

  Future<User?> getUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString("token");
    final String? user_id = sp.getString("user_id");
    final String? user_name = sp.getString("user_name");

    final dynamic user = User(
      token: token,
      id: user_id,
      fullName: user_name,
    );

    return user;
  }

  Future<String?> getUserToken() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? token = sp.getString("token");
    return token;
  }

  Future<String?> getUserId() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? user_id = sp.getString("user_id");
    return user_id;
  }

  Future<String?> getUserName() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    final String? user_name = sp.getString("user_name");
    return user_name;
  }
}
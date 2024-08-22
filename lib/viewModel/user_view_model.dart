import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:lecsens/models/user_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserViewModel with ChangeNotifier {
  Future<bool> saveCurrentUser(User user) async {
    SharedPreferences sp = await SharedPreferences.getInstance();

    String userJson = jsonEncode(user.toJson());
    sp.setString('user', userJson);
    notifyListeners();

    return true;
  }

  Future<bool> removeUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    sp.remove("user");
    notifyListeners();
    return true;
  }

  Future<User?> getCurrentUser() async {
    final SharedPreferences sp = await SharedPreferences.getInstance();
    String? userJson = sp.getString("user");

    if (userJson != null) {
      Map<String, dynamic> userMap = jsonDecode(userJson);
      return User.fromJson(userMap);
    }

    return null;
  }
}
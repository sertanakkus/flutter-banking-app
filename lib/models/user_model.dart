import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? email;
  String? username;
  String? password;
  String? phone;

  UserModel({this.email, this.phone, this.username, this.password});

  void setEmail(String value) {
    email = value;
    notifyListeners();
  }

  void setUsername(String value) {
    username = value;
    notifyListeners();
  }

  void setPassword(String value) {
    password = value;
    notifyListeners();
  }

  void setPhone(String value) {
    phone = value;
    notifyListeners();
  }
}

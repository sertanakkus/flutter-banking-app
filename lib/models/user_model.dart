import 'package:flutter/material.dart';

class UserModel extends ChangeNotifier {
  String? email;
  String? username;
  String? password;
  String? phone;
  List<Map>? cards;
  num? totalBalance;

  UserModel({this.email, this.phone, this.username, this.password, this.cards, this.totalBalance});

  UserModel.fromJson(Map json) {
    email = json["email"];
    username = json["username"];
    password = json["password"];
    phone = json["phone"];
    cards = json["cards"];
    totalBalance = json["totalBalance"];
  }

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

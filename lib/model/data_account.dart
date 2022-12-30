import 'package:flutter/material.dart';

class Account {
  String? id;
  String? email;
  String? password;
  String? firstname;
  String? lastname;
  int? gender;

  Account(
      {this.id,
      this.email,
      this.password,
      this.firstname,
      this.lastname,
      this.gender});

  static int parseIntFromJson(dynamic number, {int defaultVal = 0}) {
    // Double
    if (number is double)
      return number.round();
    // Int
    else if (number is int)
      return number;
    else if (number is String) {
      // String double
      if (number.contains('.')) {
        return double.parse(number).round();
      } else {
        // May be string int
        return int.parse(number);
      }
    }
    return defaultVal;
  }

  factory Account.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String email = data?['email'];
    final String password = data?['password'];
    final String? firstname = data?['firstname'];
    final String? lastname = data?['lastname'];
    final int? gender = parseIntFromJson(data?['gender']);
    return Account(
        id: id,
        email: email,
        password: password,
        firstname: firstname,
        lastname: lastname,
        gender: gender);
  }
}

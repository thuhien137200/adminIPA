import 'package:flutter/material.dart';

class Account {
  String? id;
  String? email;
  String? password;

  Account({this.id, this.email, this.password});

  factory Account.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String email = data?['email'];
    final String password = data?['password'];
    return Account(id: id, email: email, password: password);
  }
}

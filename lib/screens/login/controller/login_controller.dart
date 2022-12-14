import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/data_account.dart';
import '../component/style.dart';

class LoginController {
  static List<Account> data = [];

  void methodLogin(BuildContext context, String username, String password,
      List<Account> data) {
    username = username.trim();
    password = password.trim();
    if (username == "") {
      Style().messages("User don't able empty");
      return;
    }
    if (password == "") {
      Style().messages("Password don't able empty");
      return;
    }
    for (int i = 0; i < data.length; i++) {
      if (data[i].email == username) {
        if (data[i].password == password) {
          Style().messages("Login successful");
          Navigator.pop(context);
          Navigator.of(context)
              .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          return;
        } else {
          Style().messages("User name does not exist or password is wrong");
          return;
        }
      }
    }
    Style().messages("User does not exist");
  }
}

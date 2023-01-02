import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../main.dart';
import '../../../model/data_account.dart';
import '../component/style.dart';

class LoginController {
  static List<Account> data = [];

  static String? idUser;
  static Account? currentUser;

  Future<int> methodLogin(
      BuildContext context, String username, String password) async {
    username = username.trim();
    password = password.trim();
    debugPrint(data.length.toString());
    for (int i = 0; i < data.length; i++) {
      if (data[i].email == username) {
        if (data[i].password == password) {
          Style().messages("Login successful");
          idUser = data[i].id;
          currentUser = data[i];
          // Navigator.pop(context);
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setBool("isLoggedIn", true);

          idUser = data[i].id;
          currentUser = data[i];
          // Navigator.pop(context);
          // Navigator.of(context).popUntil((route) => route.isFirst);
          // Navigator.of(context)
          //     .push(MaterialPageRoute(builder: (context) => MyHomePage()));
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).popUntil((route) => route.isFirst);
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const MyHomePage()));
          });
          return 0;
        } else {
          // Style().messages("User name does not exist or password is wrong");
          return 2;
        }
      }
    }
    return 1;
    // Style().messages("User does not exist");
  }
}

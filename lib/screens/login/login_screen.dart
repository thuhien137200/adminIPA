import 'package:flutter/material.dart';

import '../../model/data_account.dart';
import '../../services/account_service.dart';
import 'component/login_component.dart';
import 'controller/login_controller.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: Color.fromRGBO(214, 230, 213, 1)),
        Background(),
        Body()
      ]),
    );
  }
}

class Background extends StatelessWidget {
  const Background({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    return Align(
      alignment: Alignment.centerRight,
      child: Container(
        height: height,
        width: 1000,
        child: Image(
            image: AssetImage("assets/login/background-login-admin-ipa.png"),
            fit: BoxFit.cover),
      ),
    );
  }
}

class Body extends StatelessWidget {
  const Body({Key? key}) : super(key: key);

  Future<List<Account>> loadData() async {
    List<Account>? result = [];
    result = await AccountServices().getAccountList();
    return result ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<List<Account>> snapshot) {
        if (snapshot.hasError) {
          print("Loi ${snapshot.error}");
        }
        if (snapshot.connectionState == ConnectionState.done) {
          LoginController.data = snapshot.data ?? [];
          return Container(
            width: width,
            decoration: BoxDecoration(color: Colors.white54),
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Align(child: SingleChildScrollView(child: Login())),
          );
        }
        return Container(
          width: width,
          decoration: BoxDecoration(color: Colors.white54),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
              child: SingleChildScrollView(
            child: Login(),
          )),
        );
      },
    );
  }
}

import 'package:admin_ipa/main.dart';
import 'package:admin_ipa/model/data_account.dart';
import 'package:admin_ipa/services/account_service.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Container(color: Color.fromRGBO(214, 230, 213, 1)),
        Background(),
        Login()
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

class Login extends StatelessWidget {
  const Login({Key? key}) : super(key: key);

  Future<List<Account>> loadData() async {
    List<Account>? result = [];
    result = await AccountServices().getAccountList();
    return result ?? [];
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width / 2;
    bool isChecked = false;
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return FutureBuilder(
      future: loadData(),
      builder: (context, AsyncSnapshot<List<Account>> snapshot) {
        return Container(
          width: width,
          decoration: BoxDecoration(color: Colors.white54),
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Align(
              child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Welcome",
                    style: TextStyle(
                        fontSize: 40,
                        color: Color.fromRGBO(56, 67, 55, 1),
                        decoration: TextDecoration.none,
                        fontFamily: "Manrope-ExtraBold")),
                SizedBox(
                  width: 1,
                  height: 10,
                ),
                Text(
                  "Email",
                  style: textStyle(),
                ),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 300,
                  decoration: boxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                        hintText: "Enter the email",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none),
                  ),
                ),
                SizedBox(
                  width: 1,
                  height: 10,
                ),
                Text("Password", style: textStyle()),
                Container(
                  margin: EdgeInsets.all(10),
                  height: 50,
                  width: 300,
                  decoration: boxDecoration(),
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: InputDecoration(
                        hintText: "Password",
                        hintStyle: TextStyle(color: Colors.grey.shade400),
                        border: InputBorder.none),
                  ),
                ),
                Container(
                  width: 300,
                  child: Text(
                    "Forget password?",
                    style: textStyle(),
                    textAlign: TextAlign.right,
                  ),
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: Align(
                    child: GestureDetector(
                      onTap: () {
                        if (snapshot.hasError) {
                          print("Loi ${snapshot.error}");
                        }
                        if (snapshot.connectionState == ConnectionState.done) {
                          // print(snapshot.data!.length);
                          for (int i = 0;
                              i < (snapshot.data ?? []).length;
                              i++) {
                            if (snapshot.data![i].email ==
                                    emailController.text &&
                                snapshot.data![i].password ==
                                    passwordController.text) {
                              Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => MyHomePage()));
                            }
                          }
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 200,
                        decoration: BoxDecoration(
                          color: Color.fromRGBO(167, 201, 165, 1),
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Align(
                            child: Text("Login",
                                style: TextStyle(
                                  fontSize: 18,
                                  color: Color.fromRGBO(56, 67, 55, 1),
                                  fontFamily: "Manrope",
                                  decoration: TextDecoration.none,
                                ))),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )),
        );
      },
    );
  }

  TextStyle textStyle() {
    return TextStyle(
      fontSize: 16,
      color: Color.fromRGBO(56, 67, 55, 1),
      fontFamily: "Manrope",
      decoration: TextDecoration.none,
    );
  }

  BoxDecoration boxDecoration() => BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color.fromRGBO(167, 201, 165, 1)));
}

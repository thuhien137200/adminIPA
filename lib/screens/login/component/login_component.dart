import 'package:admin_ipa/screens/login/component/style.dart';
import 'package:flutter/material.dart';

import '../../../main.dart';
import '../../../model/data_account.dart';
import '../../../services/account_service.dart';
import '../controller/login_controller.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  static int index = 0;

  @override
  Widget build(BuildContext context) {
    if (index == 1) return sendToMail();
    if (index == 2) return confirmMail();
    if (index == 3) return resetPassword();
    if (index == 4) return successChangePassword();
    return login();
  }

  Widget successChangePassword() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 450,
          child: Text(
            "New password confirmed successful",
            style: Style().styleTextHeader(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 1,
          height: 5,
        ),
        Container(
          width: 400,
          child: Text(
            "You have successfully confirm your new password. Please, use your new password when logging in.",
            overflow: TextOverflow.visible,
            style: Style().styleTextSmall(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 1,
          height: 80,
        ),
        Container(
          width: 400,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Align(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(167, 201, 165, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                    child: Text("Okay",
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
    );
  }

  Widget confirmMail() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          child: Row(children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromRGBO(56, 67, 55, 1),
                size: 30,
              ),
            ),
            Text("Back, Signin with account", style: Style().styleTextSmall()),
          ]),
        ),
        SizedBox(
          width: 1,
          height: 10,
        ),
        Container(
          width: 450,
          child: Text(
            "Password reset e-mail has been sent",
            style: Style().styleTextHeader(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 1,
          height: 5,
        ),
        Container(
          width: 400,
          child: Text(
            "A password rest email has been sent to your e-mail address.",
            overflow: TextOverflow.visible,
            style: Style().styleTextSmall(),
            textAlign: TextAlign.center,
          ),
        ),
        SizedBox(
          width: 1,
          height: 80,
        ),
        Container(
          width: 400,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Align(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 3;
                });
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(167, 201, 165, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                    child: Text("Set a new password",
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
    );
  }

  Widget sendToMail() {
    TextEditingController emailController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 300,
          child: Row(children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  index = 0;
                });
              },
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: Color.fromRGBO(56, 67, 55, 1),
                size: 30,
              ),
            ),
            Text("Back, Signin with account", style: Style().styleTextSmall()),
          ]),
        ),
        SizedBox(
          width: 1,
          height: 10,
        ),
        Text("Forgot your password?", style: Style().styleTextHeader()),
        SizedBox(
          width: 1,
          height: 5,
        ),
        Container(
          width: 300,
          child: Flexible(
            child: Text(
                "Please, enter your e-mail address below to receive your user and a new password.",
                overflow: TextOverflow.visible,
                style: Style().styleTextSmall()),
          ),
        ),
        SizedBox(
          width: 1,
          height: 30,
        ),
        Text("Email address *", style: Style().textStyle()),
        Style().customBoxInput(emailController, "Enter the email"),
        SizedBox(
          width: 1,
          height: 10,
        ),
        Container(
          width: 300,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Align(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 2;
                });
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(167, 201, 165, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                    child: Text("Reset password",
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
    );
  }

  static String textErrorEmail = "";
  static String textErrorPassword = "";
  static String textEmail = "";
  static String textPassword = "";

  Widget login() {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    emailController.text = textEmail;
    passwordController.text = textPassword;
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Welcome", style: Style().styleTextHeader()),
        SizedBox(
          width: 1,
          height: 10,
        ),
        Text("Email", style: Style().textStyle()),
        Style().customBoxInput(emailController, "Enter the email"),
        Text(textErrorEmail, style: Style().errorTextStyle()),
        SizedBox(
          width: 1,
          height: 10,
        ),
        Text("Password", style: Style().textStyle()),
        Style().customBoxInputPassword(passwordController, "Password"),
        Text(textErrorPassword, style: Style().errorTextStyle()),
        Container(
          width: 300,
          child: GestureDetector(
            onTap: () {
              setState(() {
                index = 1;
              });
            },
            child: Text(
              "Forget password?",
              style: Style().textStyle(),
              textAlign: TextAlign.right,
            ),
          ),
        ),
        Container(
          width: 300,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Align(
            child: GestureDetector(
              onTap: () {
                String errorEmail = "";
                String errorPassword = "";
                textEmail = emailController.text.trim();
                textPassword = passwordController.text.trim();
                if (emailController.text.trim() == "" ||
                    passwordController.text.trim() == "") {
                  if (emailController.text.trim() == "")
                    errorEmail = "Username don't able empty";
                  if (passwordController.text.trim() == "")
                    errorPassword = "Password don't able empty";

                  setState(() {
                    textErrorEmail = errorEmail;
                    textErrorPassword = errorPassword;
                  });
                  return;
                }
                int re = LoginController().methodLogin(
                    context, emailController.text, passwordController.text);
                if (re == 1) {
                  errorEmail = "User does not exist";
                  setState(() {
                    textErrorEmail = errorEmail;
                    textErrorPassword = errorPassword;
                  });
                }
                if (re == 2) {
                  errorPassword =
                      "User name does not exist or password is wrong";
                  setState(() {
                    textErrorEmail = errorEmail;
                    textErrorPassword = errorPassword;
                  });
                }
                if (re == 0) {
                  String errorEmail = "";
                  String errorPassword = "";
                  textEmail = "";
                  textPassword = "";
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
    );
  }

  Widget resetPassword() {
    TextEditingController passwordController = TextEditingController();
    TextEditingController confirmpasswordController = TextEditingController();
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            width: 450,
            child: Text("Please, Enter a new password below.",
                style: Style().styleTextHeader())),
        SizedBox(
          width: 1,
          height: 30,
        ),
        Text("New password*", style: Style().textStyle()),
        Style().customBoxInputPassword(passwordController, "Password"),
        SizedBox(
          width: 1,
          height: 10,
        ),
        Text("Confirm a new password*", style: Style().textStyle()),
        Style().customBoxInputPassword(
            confirmpasswordController, "Confirm password"),
        SizedBox(
          width: 1,
          height: 80,
        ),
        Container(
          width: 300,
          margin: EdgeInsets.symmetric(vertical: 10),
          child: Align(
            child: GestureDetector(
              onTap: () {
                setState(() {
                  index = 4;
                });
              },
              child: Container(
                height: 50,
                width: 200,
                decoration: BoxDecoration(
                  color: Color.fromRGBO(167, 201, 165, 1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Align(
                    child: Text("Save",
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
    );
  }
}

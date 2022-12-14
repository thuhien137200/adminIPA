import 'package:admin_ipa/model/data_side_bar.dart';
import 'package:flutter/material.dart';

import '../../../controller/color_theme_controller.dart';
import '../style/style.dart';

class PasswordSettings extends StatelessWidget {
  PasswordSettings({Key? key}) : super(key: key);

  TextEditingController currentPasswordController = TextEditingController();
  TextEditingController newPasswordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Expanded(flex: 1, child: changePassword(width)),
        (width > 800)
            ? SizedBox(
                width: 10,
                height: 10,
              )
            : Container(),
        (width > 800)
            ? Expanded(flex: 1, child: requirementPassword())
            : Container(),
      ],
    );
  }

  Container requirementPassword() {
    return Container(
        padding: EdgeInsets.all(20),
        decoration: Style().boxDecoration1(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Password Requirements",
              style: Style().styleTextHeader2(),
            ),
            Text(
              "To create a new pasword, you have to meet all of the following requirements:",
              style: Style().textStyleContent(),
            ),
            Text(
              "     - Mininum 8 character",
              style: Style().textStyleContent(),
            ),
            Text(
              "     - At least on special character",
              style: Style().textStyleContent(),
            ),
            Text(
              "     - At least one number",
              style: Style().textStyleContent(),
            ),
            Text(
              "     - Can't be the same as previous",
              style: Style().textStyleContent(),
            ),
          ],
        ));
  }

  Container changePassword(double width) {
    return Container(
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          "Password",
          style: Style().styleTextHeader(),
        ),
        Text(
          "To safely change your password, we encourage you to do the following:",
          style: Style().textStyleContent(),
        ),
        (width <= 800)
            ? SizedBox(
                width: 10,
                height: 10,
              )
            : Container(),
        (width <= 800) ? requirementPassword() : Container(),
        SizedBox(
          width: 1,
          height: 30,
        ),
        customTextBox(
            currentPasswordController, "Current Password", "Current Password"),
        customTextBox(newPasswordController, "A new Password", "Password"),
        customTextBox(confirmPasswordController, "Confirm a new Password",
            "Confirm Password"),
        Align(
          child: Container(
            height: 50,
            width: 100,
            padding: EdgeInsets.all(10),
            margin: EdgeInsets.all(10),
            decoration: Style().boxDecorationButton(),
            child: Text(
              "Save",
              textAlign: TextAlign.center,
              style: Style().styleTextHeader2(),
            ),
          ),
        )
      ]),
    );
  }

  Widget customTextBox(
      TextEditingController controller, String content, String labelContent) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(
          content,
          style: Style().styleTextHeader2(),
        ),
        Container(
            margin: EdgeInsets.only(top: 10, bottom: 25),
            padding: EdgeInsets.symmetric(horizontal: 20),
            height: 50,
            child: TextField(
                controller: controller,
                obscureText: true,
                style: TextStyle(color: ColorController().getColor().colorText),
                decoration:
                    Style().inputDecoration('******', labelContent, null))),
      ]),
    );
  }
}

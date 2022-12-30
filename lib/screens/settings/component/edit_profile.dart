import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/model/data_account.dart';
import 'package:admin_ipa/screens/login/controller/login_controller.dart';
import 'package:flutter/material.dart';

import '../../../services/account_service.dart';
import '../style/style.dart';

class EditProfile extends StatelessWidget {
  EditProfile({Key? key}) : super(key: key);

  TextEditingController emailController = TextEditingController();
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    return FutureBuilder(
        future: AccountServices().getAccountCurrent(),
        builder: (context, AsyncSnapshot<Account> snapshot) {
          if (snapshot.hasData) {
            LoginController.currentUser = snapshot.data;
            return Column(
              children: [
                customHeader(width),
                customDivider(),
                Body(width),
              ],
            );
          }
          return Column(
            children: [
              customHeader(width),
              customDivider(),
              Body(width),
            ],
          );
        });
  }

  Row Body(double width) {
    if (width < 630)
      GenderCheckBox.checkRow = 0;
    else
      GenderCheckBox.checkRow = 1;
    int? genderIndex = LoginController.currentUser!.gender;
    GenderCheckBox.selected = genderIndex ?? 0;
    emailController.text = LoginController.currentUser!.email ?? "";
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
            flex: 2,
            child: Container(
                // color: Colors.yellow.shade100,
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "User information",
                  style: Style().styleTextHeader1(),
                ),
                Text(
                  "       Enter the required information below to register. You can change it anytime you want.",
                  style: Style().textStyleContent(),
                ),
                (width <= 1000)
                    ? SizedBox(
                        height: 30,
                        width: 5,
                      )
                    : Container(),
                (width <= 1000) ? customBoxAvatar() : Container(),
                SizedBox(
                  height: 30,
                  width: 5,
                ),
                Text(
                  "Email address",
                  style: Style().styleTextHeader2(),
                ),
                Container(
                    margin: EdgeInsets.only(top: 10, bottom: 25),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    height: 50,
                    child: TextField(
                        controller: emailController,
                        style: TextStyle(
                            color: ColorController().getColor().colorText),
                        decoration: Style().inputDecoration(
                            'email137@domain.com',
                            "Email",
                            Icon(Icons.alternate_email_rounded,
                                color: ColorController()
                                    .getColor()
                                    .colorText
                                    .withOpacity(0.8))))),
                Text(
                  "Full name",
                  style: Style().styleTextHeader2(),
                ),
                customrBoxName(width),
                SizedBox(
                  height: 35,
                  width: 5,
                ),
                Text(
                  "Your gender",
                  style: Style().styleTextHeader2(),
                ),
                SelectGender()
              ],
            ))),
        (width > 1000)
            ? SizedBox(
                height: 5,
                width: 20,
              )
            : Container(),
        (width > 1000)
            ? Expanded(flex: 1, child: customBoxAvatar())
            : Container()
      ],
    );
  }

  Widget customrBoxName(double width) {
    firstNameController.text = LoginController.currentUser!.firstname ?? "";
    lastNameController.text = LoginController.currentUser!.lastname ?? "";
    Widget firstName = Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: TextField(
            controller: firstNameController,
            style: TextStyle(color: ColorController().getColor().colorText),
            decoration: Style().inputDecoration('Olivia', "First name", null)));
    Widget lastName = Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 20),
        height: 50,
        child: TextField(
            controller: lastNameController,
            style: TextStyle(color: ColorController().getColor().colorText),
            decoration: Style().inputDecoration('Ava', "Last name", null)));
    if (width > 680) {
      return Row(
        children: [
          Flexible(
            flex: 1,
            child: firstName,
          ),
          Flexible(
            flex: 1,
            child: lastName,
          ),
        ],
      );
    }
    return Column(
      children: [firstName, lastName],
    );
  }

  Container customBoxAvatar() {
    return Container(
      // color: Colors.red.shade100,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Profile photo",
            style: Style().styleTextHeader2(),
          ),
          SizedBox(
            height: 30,
            width: 5,
          ),
          Align(
            child: CircleAvatar(
              radius: 120,
              backgroundImage:
                  AssetImage("assets/images/login_settings/avatar.png"),
              child: Align(
                alignment: Alignment.bottomRight,
                child: Icon(Icons.camera_alt,
                    color: Color.fromRGBO(124, 116, 228, 1), size: 30),
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget customHeader(double width) {
    if (width > 620) {
      return Row(
        children: [
          Text(
            "Information",
            style: Style().styleTextHeader(),
          ),
          Spacer(),
          GestureDetector(
            onTap: () {
              Map<String, dynamic> data = new Map();
              if (emailController.text != null)
                data['email'] = emailController.text;
              if (firstNameController.text != null)
                data['firstname'] = firstNameController.text;
              if (lastNameController.text != null)
                data['lastname'] = lastNameController.text;
              data['gender'] = GenderCheckBox.selected;
              AccountServices().updateAccountCurrent(data);
            },
            child: Container(
              decoration: Style().boxDecorationButton(),
              padding: EdgeInsets.all(10),
              child: Text(
                "Confirm",
                style: Style().textStyleContent(),
              ),
            ),
          )
        ],
      );
    }

    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Information",
          style: Style().styleTextHeader(),
        ),
        Container(
          decoration: Style().boxDecorationButton(),
          padding: EdgeInsets.all(10),
          child: Text(
            "Confirm",
            style: Style().textStyleContent(),
          ),
        )
      ],
    );
  }

  Container customDivider() {
    return Container(
      margin: EdgeInsets.only(top: 10, bottom: 20),
      child: Divider(
        color: Color.fromRGBO(124, 116, 228, 1),
      ),
    );
  }
}

class GenderCheckBox {
  static int selected = 0;
  static int checkRow = 1;
}

class SelectGender extends StatefulWidget {
  const SelectGender({Key? key}) : super(key: key);

  @override
  State<SelectGender> createState() => _SelectGenderState();
}

class _SelectGenderState extends State<SelectGender> {
  Widget checkBox(int index) {
    int selected = GenderCheckBox.selected;

    if (index == selected)
      return Icon(
        Icons.radio_button_checked,
        color: ColorController().getColor().colorText,
      );
    return GestureDetector(
      onTap: () {
        setState(() {
          GenderCheckBox.selected = index;
        });
      },
      child: Icon(
        Icons.radio_button_off,
        color: ColorController().getColor().colorText,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (GenderCheckBox.checkRow == 0) {
      return Container(
        margin: EdgeInsets.only(top: 10),
        padding: EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          children: [
            Row(
              children: [
                checkBox(0),
                Text(
                  "  Male",
                  style: Style().textStyleContent(),
                ),
              ],
            ),
            SizedBox(
              width: 1,
              height: 5,
            ),
            Row(
              children: [
                checkBox(1),
                Text(
                  "  Female",
                  style: Style().textStyleContent(),
                ),
              ],
            ),
            SizedBox(
              width: 1,
              height: 5,
            ),
            Row(
              children: [
                checkBox(2),
                Text(
                  "  Non-binary",
                  style: Style().textStyleContent(),
                ),
              ],
            ),
          ],
        ),
      );
    }
    return Container(
      margin: EdgeInsets.only(top: 10),
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Row(
        children: [
          checkBox(0),
          Text(
            "  Male",
            style: Style().textStyleContent(),
          ),
          Spacer(),
          checkBox(1),
          Text(
            "  Female",
            style: Style().textStyleContent(),
          ),
          Spacer(),
          checkBox(2),
          Text(
            "  Non-binary",
            style: Style().textStyleContent(),
          ),
        ],
      ),
    );
  }
}

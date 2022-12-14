import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/login/component/style.dart';
import 'package:admin_ipa/screens/settings/component/body_setting.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({Key? key}) : super(key: key);

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: ColorController().getColor().colorBody,
        child: Column(
          children: [customBoxHeader(), BodySettings()],
        ),
      ),
    );
  }

  Container customBoxHeader() {
    return Container(
      color: ColorController().getColor().colorBox,
      margin: EdgeInsets.all(15),
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            margin: EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
                color: Color.fromRGBO(180, 167, 214, 0.2),
                borderRadius: BorderRadius.circular(50)),
            child: Icon(
              Icons.settings_outlined,
              color: Color.fromRGBO(124, 116, 228, 1),
            ),
          ),
          Text("Settings",
              style: TextStyle(
                fontSize: 18,
                color: Color.fromRGBO(124, 116, 228, 1),
                fontFamily: "Manrope",
                decoration: TextDecoration.none,
              ))
        ],
      ),
    );
  }
}

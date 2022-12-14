import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/settings/component/account_security.dart';
import 'package:admin_ipa/screens/settings/component/edit_profile.dart';
import 'package:admin_ipa/screens/settings/component/logout_settings.dart';
import 'package:admin_ipa/screens/settings/component/password.dart';
import 'package:admin_ipa/screens/settings/component/side_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';

import '../style/style.dart';

class BodySettings extends StatefulWidget {
  const BodySettings({Key? key}) : super(key: key);

  @override
  State<BodySettings> createState() => _BodySettingsState();
}

class _BodySettingsState extends State<BodySettings> {
  static int selectedSideBar = 0;
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height - 115;
    double _width = MediaQuery.of(context).size.width * 10 / 12 - 40;
    Size size = Size(_width, _height);
    double _widthSideBar = 220;
    if (_width < 850) _widthSideBar = 100;
    return Container(
      padding: EdgeInsets.only(left: 15, right: 15, bottom: 15),
      child: Row(
        children: [
          Container(
            height: _height,
            width: _widthSideBar,
            // color: Colors.amber.shade100,
            child: SingleChildScrollView(
                child: customSideBar(Size(_widthSideBar, _height))),
          ),
          SizedBox(width: 10, height: 5),
          Container(
            height: _height,
            width: _width - _widthSideBar,
            padding: EdgeInsets.all(20),
            decoration: Style().boxDecoration(),
            child: SingleChildScrollView(child: CustomNavigatorBody()),
          )
        ],
      ),
    );
  }

  Widget CustomNavigatorBody() {
    if (selectedSideBar == 1) return AccountSecuritySettings();
    if (selectedSideBar == 2) return PasswordSettings();
    if (selectedSideBar == 3) return LogoutSettings();
    return EditProfile();
  }

  Widget customSideBar(Size size) {
    List<Widget> child1 = [], child2 = [];
    for (int i = 0; i < 4; i++) {
      Widget re = GestureDetector(
        onTap: () {
          setState(() {
            selectedSideBar = i;
          });
        },
        child: SideBarSettings()
            .customBoxSideBar(i, selectedSideBar, size.width - 20 * 2),
      );
      if (i < 3)
        child1.add(re);
      else
        child2.add(re);
    }
    return Column(
      children: [
        Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.all(10),
            decoration: Style().boxDecoration(),
            child: Column(
              children: child1,
            )),
        Container(
            margin: EdgeInsets.all(10),
            decoration: Style().boxDecoration(),
            padding: EdgeInsets.all(10),
            child: Column(
              children: child2,
            )),
      ],
    );
  }
}

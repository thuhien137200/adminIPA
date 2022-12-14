import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SideBarSettings {
  Widget customBoxSideBar(int index, int selected, double width) {
    List<String> dataContent = [
      "Edit Profile",
      "Account Security",
      "Password",
      "Logout"
    ];
    List<IconData> dataIconUnChecked = [
      Icons.account_box_outlined,
      Icons.admin_panel_settings_outlined,
      Icons.vpn_key_outlined,
      Icons.meeting_room_outlined
    ];
    List<IconData> dataIconChecked = [
      Icons.account_box_rounded,
      Icons.admin_panel_settings,
      Icons.vpn_key,
      Icons.meeting_room
    ];
    return Container(
      height: 50,
      width: width,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: index == selected
          ? BoxDecoration(
              color: Color.fromRGBO(119, 102, 136, 0.1),
              borderRadius: BorderRadius.circular(10))
          : null,
      child: width > 60
          ? Text(
              dataContent[index],
              style: TextStyle(
                fontSize: 16,
                // color: ColorController().getColor().colorText.withOpacity(0.5),
                color: index == selected
                    ? Color.fromRGBO(124, 116, 228, 0.8)
                    : Color.fromRGBO(124, 116, 228, 0.6),
                fontFamily: "Manrope",
                decoration: TextDecoration.none,
              ),
            )
          : index == selected
              ? Icon(dataIconChecked[index],
                  color: Color.fromRGBO(124, 116, 228, 0.8))
              : Icon(dataIconUnChecked[index],
                  color: Color.fromRGBO(124, 116, 228, 0.6)),
    );
  }
}

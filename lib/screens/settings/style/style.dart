import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Style {
  BoxDecoration boxDecoration() {
    return BoxDecoration(
        color: ColorController().getColor().colorBox,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color:
                  ColorController().getColor().colorShadowBox.withOpacity(0.5),
              blurRadius: 10)
        ]);
  }

  BoxDecoration boxDecoration1() {
    return BoxDecoration(
        color: Color.fromRGBO(162, 196, 201, 1),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color: ColorController().getColor().colorShadowBox.withOpacity(1),
              blurRadius: 10)
        ]);
  }

  BoxDecoration boxDecorationButton() {
    return BoxDecoration(
        color: Color.fromRGBO(162, 196, 201, 1),
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
              color:
                  ColorController().getColor().colorShadowBox.withOpacity(0.5),
              blurRadius: 10)
        ]);
  }

  InputDecoration inputDecoration(
      String hintText, String labelText, Icon? suffixIcon) {
    return InputDecoration(
      enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey)),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: BorderSide(color: Color.fromRGBO(124, 116, 228, 1)),
      ),
      hintText: hintText,
      hintStyle: TextStyle(
          color: ColorController().getColor().colorText.withOpacity(0.5)),
      labelText: labelText,
      labelStyle: TextStyle(color: ColorController().getColor().colorText),
      suffixIcon: suffixIcon,
    );
  }

  TextStyle styleTextHeader() {
    return TextStyle(
        fontSize: 40,
        color: ColorController().getColor().colorText.withOpacity(0.8),
        decoration: TextDecoration.none,
        fontFamily: "Manrope-ExtraBold");
  }

  TextStyle styleTextHeader1() {
    return TextStyle(
        fontSize: 26,
        color: ColorController().getColor().colorText.withOpacity(0.8),
        decoration: TextDecoration.none,
        fontFamily: "Manrope-ExtraBold");
  }

  TextStyle styleTextHeader2() {
    return TextStyle(
        fontSize: 20,
        color: ColorController().getColor().colorText.withOpacity(0.8),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w500,
        fontFamily: "Manrope-ExtraBold");
  }

  TextStyle styleTextHeader3() {
    return TextStyle(
        fontSize: 18,
        color: ColorController().getColor().colorText.withOpacity(0.8),
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w500,
        fontFamily: "Manrope-ExtraBold");
  }

  TextStyle styleTextSmall() {
    return TextStyle(
      fontSize: 14,
      color: ColorController().getColor().colorText.withOpacity(0.8),
      fontFamily: "Manrope",
      decoration: TextDecoration.none,
    );
  }

  TextStyle textStyleContent() {
    return TextStyle(
        fontSize: 16,
        color: ColorController().getColor().colorText.withOpacity(0.8),
        fontFamily: "Manrope",
        decoration: TextDecoration.none,
        fontWeight: FontWeight.w100);
  }
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class Style {
  void messages(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.TOP_LEFT,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Container customBoxInput(TextEditingController controller, String name) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: 300,
      decoration: boxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: customTextField(controller, name),
    );
  }

  Container customBoxInputPassword(
      TextEditingController controller, String name) {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      width: 300,
      decoration: boxDecoration(),
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: customTextPasswordField(controller, name),
    );
  }

  TextField customTextPasswordField(
      TextEditingController controller, String name) {
    return TextField(
      controller: controller,
      obscureText: true,
      decoration: InputDecoration(
          hintText: name,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: InputBorder.none),
    );
  }

  TextField customTextField(TextEditingController controller, String name) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
          hintText: name,
          hintStyle: TextStyle(color: Colors.grey.shade400),
          border: InputBorder.none),
    );
  }

  TextStyle styleTextHeader() {
    return TextStyle(
        fontSize: 40,
        color: Color.fromRGBO(56, 67, 55, 1),
        decoration: TextDecoration.none,
        fontFamily: "Manrope-ExtraBold");
  }

  TextStyle styleTextSmall() {
    return TextStyle(
      fontSize: 14,
      color: Color.fromRGBO(56, 67, 55, 0.8),
      fontFamily: "Manrope",
      decoration: TextDecoration.none,
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

  TextStyle errorTextStyle() {
    return TextStyle(
      fontSize: 14,
      color: Colors.red,
      fontFamily: "Manrope",
      decoration: TextDecoration.none,
    );
  }

  BoxDecoration boxDecoration() => BoxDecoration(
      color: Colors.white70,
      borderRadius: BorderRadius.circular(15),
      border: Border.all(color: Color.fromRGBO(167, 201, 165, 1)));
}

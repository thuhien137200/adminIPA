import 'dart:async';

import 'package:flutter/material.dart';

class ColorController {
  static int index = 0;

  Stream<ColorTheme?> getColorStream() {
    Stream<ColorTheme> stream = Stream.value(getColor());
    return stream;
  }

  ColorTheme getColor() {
    ColorTheme dartTheme = ColorTheme(
        colorBody: Color.fromRGBO(19, 19, 28, 1),
        colorBox: Color.fromRGBO(29, 29, 43, 1),
        colorShadowBox: Colors.black,
        colorText: Colors.white);
    ColorTheme lightTheme = ColorTheme(
        colorBody: Color.fromRGBO(229, 232, 235, 1),
        colorBox: Color.fromRGBO(249, 249, 249, 1),
        colorShadowBox: Color.fromRGBO(91, 90, 88, 1),
        colorText: Colors.black);
    List<ColorTheme> listColorTheme = [dartTheme, lightTheme];
    return listColorTheme[index];
  }

  void changeColor() {
    index = 1 - index;
  }
}

class ColorTheme {
  Color colorBody;
  Color colorBox;
  Color colorShadowBox;
  Color colorText;
  ColorTheme(
      {required this.colorBody,
      required this.colorBox,
      required this.colorShadowBox,
      required this.colorText});
}

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../controller/color_theme_controller.dart';

class StyleTable {
  TextStyle textStyleTableContent() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope",
      fontSize: 16,
      fontWeight: FontWeight.w100);
  TextStyle textStyleTableHeader() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope-ExtraBold",
      fontSize: 20,
      fontWeight: FontWeight.w100);
  TextStyle textStyleHeader() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope-ExtraBold",
      decoration: TextDecoration.none,
      fontSize: 24,
      fontWeight: FontWeight.w100);

  DataRow RowEmpty() {
    return const DataRow(cells: [
      DataCell(Text("Empty")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  TextField customInputText(TextEditingController name, String st) {
    return TextField(
      controller: name,
      maxLines: 10,
      style: TextStyle(color: ColorController().getColor().colorText),
      decoration: InputDecoration(
          hintText: st,
          hintStyle: TextStyle(
              color: ColorController().getColor().colorText.withOpacity(0.5)),
          border: InputBorder.none),
    );
  }

  BoxDecoration decorationBox() {
    return BoxDecoration(
        color: ColorController().getColor().colorBox,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color:
                  ColorController().getColor().colorShadowBox.withOpacity(0.5),
              blurRadius: 10)
        ]);
  }

  BoxDecoration decorationBoxAdd() {
    return BoxDecoration(
        color: Color.fromRGBO(129, 105, 155, 0.1),
        border: Border.all(
            width: 2.0,
            color: Color.fromRGBO(124, 116, 228, 1),
            style: BorderStyle.solid),
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(
              color:
                  ColorController().getColor().colorShadowBox.withOpacity(0.5),
              blurRadius: 10)
        ]);
  }

  void messages(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }
}

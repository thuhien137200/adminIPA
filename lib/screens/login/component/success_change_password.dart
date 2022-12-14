import 'package:admin_ipa/screens/login/component/style.dart';
import 'package:flutter/material.dart';

mixin SusscessChangePassword {
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
                // setState(() {
                //   index = 0;
                // });
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
}

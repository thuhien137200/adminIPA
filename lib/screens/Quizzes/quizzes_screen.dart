import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/Quizzes/component/overview.dart';
import 'package:flutter/material.dart';

import 'component/custom_information.dart';

class QuizScreen extends StatelessWidget {
  const QuizScreen({Key? key, required this.size}) : super(key: key);
  final Size size;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: size.height,
      width: size.width,
      // color: Colors.red,
      margin: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Overview",
            style: TextStyle(
                color: ColorController().getColor().colorText,
                fontFamily: "Manrope-ExtraBold",
                decoration: TextDecoration.none,
                fontSize: 24,
                fontWeight: FontWeight.w100),
          ),
          Overview(width: size.width - 40),
          Container(
            // height: 500,
            width: size.width,
            // color: Colors.red,
            padding: EdgeInsets.all(10),
            child: CustomTable(),
          ),
          // CustomTable(),
        ]),
      ),
    );
  }
}

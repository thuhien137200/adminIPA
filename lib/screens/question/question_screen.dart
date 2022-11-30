import 'package:flutter/material.dart';

class QuestionScreen extends StatelessWidget {
  const QuestionScreen({Key? key, required this.size}) : super(key: key);
  final Size size;
  @override
  Widget build(BuildContext context) {
    return Text("Question and answers");
  }
}

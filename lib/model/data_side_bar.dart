import 'dart:ui';

import 'package:admin_ipa/screens/Quizzes/quizzes_screen.dart';
import 'package:admin_ipa/screens/account/account_screen.dart';
import 'package:admin_ipa/screens/article/article_screen.dart';
import 'package:admin_ipa/screens/company/company_screen.dart';
import 'package:admin_ipa/screens/dashboard/dashboard_screen.dart';
import 'package:admin_ipa/screens/question/question_screen.dart';
import 'package:admin_ipa/screens/settings/setting.dart';
import 'package:flutter/material.dart';

class DatabaseSideBar {
  static int selectionIndex = 0;
  List<SideBox> getData() {
    SideBox dashboard = SideBox(
        content: "Dashboard",
        iconData: Icons.dashboard_outlined,
        iconData_onClick: Icons.dashboard_rounded);
    SideBox article = SideBox(
        content: "Article",
        iconData: Icons.article_outlined,
        iconData_onClick: Icons.article_rounded);
    SideBox question = SideBox(
        content: "Question",
        iconData: Icons.question_answer_outlined,
        iconData_onClick: Icons.question_answer_rounded);
    SideBox quiz = SideBox(
        content: "Quizzes",
        iconData: Icons.assignment_outlined,
        iconData_onClick: Icons.assignment_rounded);
    SideBox account = SideBox(
        content: "Account",
        iconData: Icons.people_outlined,
        iconData_onClick: Icons.people_rounded);
    SideBox company = SideBox(
        content: "Company",
        iconData: Icons.home_repair_service_outlined,
        iconData_onClick: Icons.home_repair_service_outlined);
    SideBox setting = SideBox(
        content: "Setting",
        iconData: Icons.settings_outlined,
        iconData_onClick: Icons.settings_outlined);
    List<SideBox> result = [
      dashboard,
      article,
      question,
      quiz,
      account,
      company,
      setting
    ];
    return result;
  }

  Widget getScreen(Size size) {
    Widget dashboard = DashboardScreen(size: size);
    Widget article = ArticleScreen(size: size);
    Widget question = QuestionScreen(size: size);
    Widget quiz = QuizScreen(size: size);
    Widget account = AccountScreen(size: size);
    Widget company = CompanyScreen(size: size);
    Widget setting = SettingScreen(size: size);
    List<Widget> result = [
      dashboard,
      article,
      question,
      quiz,
      account,
      company,
      setting
    ];
    return result[selectionIndex];
  }

  Widget CustomSideBarBoxOnSelected(int index, double width) {
    SideBox data = getData()[index];
    List<Widget> child = [
      Icon(data.iconData_onClick, color: Color.fromRGBO(124, 116, 228, 1))
    ];
    if (width > 165)
      child.add(Text(
        data.content,
        textAlign: TextAlign.end,
        style: TextStyle(
            decoration: TextDecoration.none,
            color: Color.fromRGBO(124, 116, 228, 1),
            fontSize: 14,
            fontFamily: "Manrope-ExtraBold"),
      ));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
      decoration: BoxDecoration(
          // color: Color.fromRGBO(124, 116, 228, 0.1),
          color: Color.fromRGBO(129, 105, 155, 0.1),
          borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: child,
      ),
    );
  }

  Widget CustomSideBarBox(int index, double width) {
    SideBox data = getData()[index];
    List<Widget> child = [
      Icon(data.iconData, color: Color.fromRGBO(129, 105, 155, 1))
    ];
    if (width > 165)
      child.add(Text(
        data.content,
        textAlign: TextAlign.end,
        style: TextStyle(
            decoration: TextDecoration.none,
            color: Color.fromRGBO(129, 105, 155, 1),
            fontSize: 14,
            fontFamily: "Manrope-ExtraBold",
            fontWeight: FontWeight.w100),
      ));
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      padding: EdgeInsets.only(top: 20, bottom: 20, left: 20),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
      child: Row(
        children: child,
      ),
    );
  }

  Widget getCustomSideBarBox(int index, double width) {
    if (index == selectionIndex)
      return CustomSideBarBoxOnSelected(index, width);
    return CustomSideBarBox(index, width);
  }
}

class SideBox {
  String content;
  IconData iconData;
  IconData iconData_onClick;
  SideBox(
      {required this.content,
      required this.iconData,
      required this.iconData_onClick});
}

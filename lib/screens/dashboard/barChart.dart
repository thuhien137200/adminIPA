import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../../config/responsive.dart';


class BarChartCopmponent extends StatelessWidget {

  int account;
  int article;
  int question;
  int experience;
  int company;
  int quiz;
   BarChartCopmponent({
    Key? key,
    required this.account,
     required this.article,
     required this.question,
     required this.experience,
    required this.company,
     required this.quiz,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BarChart(
      BarChartData(
          borderData: FlBorderData(show: false),
          alignment: BarChartAlignment.spaceBetween,
          axisTitleData:
              FlAxisTitleData(leftTitle: AxisTitle(reservedSize: 20)),
          gridData:
              FlGridData(drawHorizontalLine: true, horizontalInterval: 30),
          titlesData: FlTitlesData(
              leftTitles: SideTitles(
                reservedSize: 30,
                getTextStyles: (value) =>
                    const TextStyle(color: Colors.grey, fontSize: 12),
                showTitles: true,
                getTitles: (value) {
                  return value==null?(value%50==0?value.toString():''):'' ;
                },
              ),
              bottomTitles: SideTitles(
                showTitles: true,
                getTextStyles: (value) =>
                    const TextStyle(color: Colors.grey, fontSize: 12),
                getTitles: (value) {
                  if (value == 0) {
                    return 'Account';
                  } else if (value == 1) {
                    return 'Article';
                  } else if (value == 2) {
                    return 'Question';
                  } else if (value == 3) {
                    return 'Experience Post';
                  } else if (value == 4) {
                    return 'Company';
                  } else if (value == 5) {
                    return 'Quiz';
                  } else {
                    return '';
                  }
                },
              )),
          barGroups: [
            BarChartGroupData(x: 0, barRods: [
              BarChartRodData(
                  y: account.toDouble(),
                  colors: [Colors.black],
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      y: 90, show: true, colors: [Color(0xffe3e3ee)])),
            ]),
            BarChartGroupData(x: 1, barRods: [
              BarChartRodData(
                  y: article.toDouble(),
                  colors: [Colors.black],
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      y: 90, show: true, colors: [Color(0xffe3e3ee)]))
            ]),
            BarChartGroupData(x: 2, barRods: [
              BarChartRodData(
                  y: question.toDouble(),
                  colors: [Colors.black],
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      y: 90, show: true, colors: [Color(0xffe3e3ee)]))
            ]),
            BarChartGroupData(x: 3, barRods: [
              BarChartRodData(
                  y: experience.toDouble(),
                  colors: [Colors.black],
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      y: 90, show: true, colors: [Color(0xffe3e3ee)]))
            ]),
            BarChartGroupData(x: 4, barRods: [
              BarChartRodData(
                  y: company.toDouble(),
                  colors: [Colors.black],
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      y: 90, show: true, colors: [Color(0xffe3e3ee)]))
            ]),
            BarChartGroupData(x: 5, barRods: [
              BarChartRodData(
                  y: quiz.toDouble(),
                  colors: [Colors.black],
                  borderRadius: BorderRadius.circular(0),
                  width: Responsive.isDesktop(context) ? 40 : 10,
                  backDrawRodData: BackgroundBarChartRodData(
                      y: 90, show: true, colors: [Color(0xffe3e3ee)]))
            ]),
          ]),
      swapAnimationDuration: Duration(milliseconds: 150), // Optional
      swapAnimationCurve: Curves.linear, // Optional
    );
  }
}

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../controller/color_theme_controller.dart';
import 'dataShared.dart';

class PieChartDetailData extends StatefulWidget {
  int article;
  int question;
  int experience;
  PieChartDetailData({
    Key? key,
    required this.article,
    required this.question,
    required this.experience,
  }) : super(key: key);

  @override
  State<PieChartDetailData> createState() => _PieChartDetailDataState();
}

class _PieChartDetailDataState extends State<PieChartDetailData> {
  @override
  void initState() {
    SharedData.numArticle = widget.article;
    SharedData.numQuestion = widget.question;
    SharedData.numExperience = widget.experience;
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<PieChartSectionData> paiChartSelectionDatas = [
      PieChartSectionData(
        color: Color(0xFFEE2727),
        value: widget.article.toDouble(),
        showTitle: false,
        radius: 16,
      ),
      PieChartSectionData(
        color: Color(0xFFFFCF26),
        value: widget.question.toDouble(),
        showTitle: false,
        radius: 19,
      ),
      PieChartSectionData(
        color: Color(0xFF2697FF),
        value: widget.experience.toDouble(),
        showTitle: false,
        radius: 25,
      ),
    ];

    return SizedBox(
      height: 200,
      child: Stack(
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 0,
              centerSpaceRadius: 70,
              startDegreeOffset: -90,
              sections: paiChartSelectionDatas,
            ),
          ),
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 16),
                Text(
                  "${SharedData.numArticle + SharedData.numQuestion + SharedData.numExperience}",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        color: ColorController().getColor().colorText,
                        fontWeight: FontWeight.w600,
                        height: 0.5,
                      ),
                ),
                Text(
                  "posts",
                  style: TextStyle(
                    color: ColorController().getColor().colorText,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

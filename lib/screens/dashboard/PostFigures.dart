import 'package:admin_ipa/screens/dashboard/pieChart.dart';
import 'package:flutter/material.dart';

import '../../controller/color_theme_controller.dart';
import 'chartCard.dart';

class PostFigures extends StatefulWidget {
  int article;
  int question;
  int experience;
  PostFigures({Key? key,
    required this.article,
    required this.question,
    required this.experience,}) : super(key: key);

  @override
  State<PostFigures> createState() => _PostFiguresState();
}

class _PostFiguresState extends State<PostFigures> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          PieChartDetailData(article: widget.article,question: widget.question,experience: widget.experience,),
          ChartCard(
            svgSrc: "assets/red.svg",
            title: "Article Post",
            amount: "${widget.article} posts",
            numOfFiles: widget.article,
          ),
          ChartCard(
            svgSrc: "assets/yellow.svg",
            title: "Question and Answer",
            amount: "${widget.question} posts",
            numOfFiles: widget.question,
          ),
          ChartCard(
            svgSrc: "assets/blue.svg",
            title: "Experience Post",
            amount: "${widget.experience} posts",
            numOfFiles: widget.experience,
          ),
        ],
      ),
    );
  }
}

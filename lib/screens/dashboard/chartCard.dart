import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ChartCard extends StatelessWidget {
  final String title, svgSrc, amount;
  final int numOfFiles;
  const ChartCard({
    Key? key,
    required this.title,
    required this.svgSrc,
    required this.amount,
    required this.numOfFiles,
}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 16),
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(width: 2, color: Color(0xFF2697FF).withOpacity(0.15)),
        borderRadius: const BorderRadius.all(
          Radius.circular(16),
        ),
      ),
      child: Row(
        children: [
          SizedBox(
            height: 70,
            width: 70,
            child: SvgPicture.asset(svgSrc),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            ),
          ),
          Text(amount)
        ],
      ),
    );
  }
}

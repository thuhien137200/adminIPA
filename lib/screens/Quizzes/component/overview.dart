import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/model/data_box_overview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

class Overview extends StatelessWidget {
  const Overview({Key? key, required this.width}) : super(key: key);
  final double width;

  Widget _buildItem(BuildContext context, int index, DataBoxOverView data) {
    List<Color> listColor = [
      Color.fromRGBO(237, 85, 85, 1),
      Color.fromRGBO(180, 196, 104, 1),
      Color.fromRGBO(184, 167, 234, 1),
      Color.fromRGBO(183, 224, 220, 1),
      Color.fromRGBO(189, 209, 160, 1),
    ];

    return Container(
      height: 90,
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: ColorController().getColor().colorBox,
        borderRadius: BorderRadius.circular(5),
        boxShadow: [
          BoxShadow(
              color:
                  ColorController().getColor().colorShadowBox.withOpacity(0.5),
              blurRadius: 10)
        ],
      ),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(
          children: [
            Container(
              height: 10,
              width: 10,
              margin: EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                  color: listColor[index],
                  borderRadius: BorderRadius.circular(50)),
            ),
            Text(
              data.content,
              style: TextStyle(
                  color: ColorController().getColor().colorText,
                  fontFamily: "Manrope",
                  decoration: TextDecoration.none,
                  fontSize: 18,
                  fontWeight: FontWeight.w100),
            ),
          ],
        ),
        Align(
          alignment: Alignment.centerRight,
          child: Text(
            data.number.toString(),
            style: TextStyle(
                // color: ColorController().getColor().colorText,
                color: listColor[index],
                fontFamily: "Manrope-ExtraBold",
                decoration: TextDecoration.none,
                fontSize: 32,
                fontWeight: FontWeight.w100),
          ),
        )
      ]),
    );
  }

  @override
  Widget build(BuildContext context) {
    List<DataBoxOverView> dataTemplate = [
      DataBoxOverView(content: "Jobs", number: 2),
      DataBoxOverView(content: "Categories", number: 10),
      DataBoxOverView(content: "Quizzes", number: 20),
      DataBoxOverView(content: "Question", number: 50)
    ];

    int crossAxisCount = (width / 200).toInt() > dataTemplate.length
        ? dataTemplate.length
        : (width / 200).toInt();
    // debugPrint(MediaQuery.of(context).size.width.toString());
    return Container(
      height: 110 * (dataTemplate.length / crossAxisCount).ceil().toDouble(),
      width: width,
      child: MasonryGridView.count(
        itemCount: dataTemplate.length,
        crossAxisCount: crossAxisCount,
        itemBuilder: (context, index) {
          return _buildItem(context, index, dataTemplate[index]);
        },
      ),
    );
  }
}

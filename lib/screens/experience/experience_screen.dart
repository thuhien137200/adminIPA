import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../model/data_experience.dart';
import '../../style/style.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late Future<List<ExperiencePost>?> _dataFuture;

  List<ExperiencePost>? _experienceFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
  }

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture =
        _db.collection('experience').get().then(_experienceFromQuerySnapshot);
    super.initState();
  }

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  Row HeaderExperience() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Experience Post',
                size: 30,
                fontWeight: FontWeight.w800,
                color: ColorController().getColor().colorText,
              ),
              PrimaryText(
                text: 'Manage All Experience Post',
                size: 16,
                fontWeight: FontWeight.w400,
                color: ColorController().getColor().colorText.withOpacity(0.5),
              )
            ]),
      ),
      Spacer(
        flex: 1,
      ),
      IconButton(
          onPressed: () {},
          icon: Icon(Icons.add, color: ColorController().getColor().colorText))
    ]);
  }

  void removeExperiencePost() {
    //dosomething
  }

  TextStyle textStyleTableHeader() => TextStyle(
      fontStyle: FontStyle.italic,
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope-ExtraBold",
      fontSize: 20,
      fontWeight: FontWeight.w100);
  TextStyle textStyleTableContent() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope",
      fontSize: 16,
      fontWeight: FontWeight.w100);

  Widget DataTableExperience() {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context,
          AsyncSnapshot<List<ExperiencePost>?> snapshot) {
        List<ExperiencePost>? topics = snapshot.data;
        return Container(
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              color: ColorController().getColor().colorBox,
              borderRadius: BorderRadius.circular(15),
              boxShadow: [
                BoxShadow(
                    color: ColorController()
                        .getColor()
                        .colorShadowBox
                        .withOpacity(0.5),
                    blurRadius: 10)
              ]),
          child: DataTable(
            columns: <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text(
                    'ID',
                    style: textStyleTableHeader(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Title',
                    style: textStyleTableHeader(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Created at',
                    style: textStyleTableHeader(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    '',
                  ),
                ),
              )
            ],
            rows: topics == null
                ? [RowEmpty()]
                : topics!
                    .map((post) => DataRow(cells: [
                          DataCell(Text(
                            post.topic_id!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Text(
                            post.title!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Text(
                            post.created_at.toString()!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: ColorController().getColor().colorText,
                              ))),
                        ]))
                    .toList(),
          ),
        );
      },
    );
    return Container(
      width: MediaQuery.of(context).size.width,
      child: DataTable(
        columns: <DataColumn>[
          DataColumn(
            label: Expanded(
              child: Text(
                'ID',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Title',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                'Created at',
                style: TextStyle(fontStyle: FontStyle.italic),
              ),
            ),
          ),
          DataColumn(
            label: Expanded(
              child: Text(
                '',
              ),
            ),
          ),
        ],
        rows: <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('1')),
              DataCell(Text('How to be handsome?')),
              DataCell(Text('02/12/2022')),
              DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2')),
              DataCell(Text('How to improve English skills')),
              DataCell(Text('01/12/2022')),
              DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('3')),
              DataCell(Text('Is English important for developers?')),
              DataCell(Text('25/11/2022')),
              DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      key: _drawerKey,
      body: SafeArea(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
                flex: 10,
                child: SafeArea(
                    child: Container(
                  color: ColorController().getColor().colorBody,
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        HeaderExperience(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        DataTableExperience()
                      ],
                    ),
                  ),
                ))),
          ],
        ),
      ),
    );
  }
}

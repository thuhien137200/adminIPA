import 'package:admin_ipa/model/data_question.dart';
import 'package:admin_ipa/screens/question/data_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../services/database_service.dart';
import '../../style/style.dart';

class QuestionScreen extends StatefulWidget {
  const QuestionScreen({Key? key}) : super(key: key);

  @override
  State<QuestionScreen> createState() => _QuestionScreenState();
}

class _QuestionScreenState extends State<QuestionScreen> {
  late Future<List<Question>?> _dataFuture;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  List<Question>? _questionsListFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<Question>? res;
    res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Question.fromJson(documentSnapshot.data());
      }
      return Question.test();
    }).toList();

    DataQuestion.dataQuestion = res ?? [];
    return res;
  }

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture =
        _db.collection('questions').get().then(_questionsListFromQuerySnapshot);
    super.initState();
  }

  Row HeaderQuestion() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Question',
                size: 30,
                fontWeight: FontWeight.w800,
                color: ColorController().getColor().colorText,
              ),
              PrimaryText(
                text: 'Manage All Question post',
                size: 16,
                fontWeight: FontWeight.w400,
                color: ColorController().getColor().colorText.withOpacity(0.5),
              ),
            ]),
      ),
      Spacer(
        flex: 1,
      ),
      IconButton(
          onPressed: () {
            
          },
          icon: Icon(
            Icons.add,
            color: ColorController().getColor().colorText,
          ))
    ]);
  }

  void removeQuestion() {
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

  Widget DataTableQuestion() {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
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
                    'Question Title',
                    style: textStyleTableHeader(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Created At',
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
              ),
            ],
            rows: DataQuestion.dataQuestion == null
                ? [RowEmpty()]
                : DataQuestion.dataQuestion
                    .map((question) => DataRow(cells: [
                          DataCell(Text(question.id!,
                              style: textStyleTableContent())),
                          DataCell(Text(question.title!,
                              style: textStyleTableContent())),
                          DataCell(Text(question.created_at.toString(),
                              style: textStyleTableContent())),
                          DataCell(IconButton(
                              //Delete
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text(
                                          'Delete QA Post',
                                          style: AppFonts.headStyle,
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            child: Center(
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.center,
                                                children: const [
                                                  Icon(Icons.warning),
                                                  SizedBox(width: 12),
                                                  Text(
                                                      'Are you sure you want to delete?'),
                                                ],
                                              ),
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text("No"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                              child: const Text("Yes"),
                                              onPressed: () {
                                                DatabaseService().deleteQA(
                                                    question.id ?? 'null');
                                                Navigator.pop(context);
                                              })
                                        ],
                                      );
                                    });
                              },
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
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          HeaderQuestion(),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2.5,
                          ),
                          DataTableQuestion()
                        ],
                      ),
                    ),
                  ),
                )),
          ],
        ),
      ),
    );
  }
}

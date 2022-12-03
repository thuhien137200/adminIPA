import 'package:admin_ipa/model/data_question.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
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
    return res;
  }


  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture = _db.collection('questions').get().then(_questionsListFromQuerySnapshot);
    super.initState();
  }


  Row HeaderQuestion()
  {
    return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  PrimaryText(
                      text: 'Question',
                      size: 30,
                      fontWeight: FontWeight.w800),
                  PrimaryText(
                    text: 'Manage All Question post',
                    size: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffa6a6a6),
                  ),

                ]),
          ),Spacer(
            flex: 1,
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ]);
  }

  void removeQuestion()
  {
    //dosomething
  }
  Widget DataTableQuestion()
  {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
        List<Question>? questions = snapshot.data;
        return Container(
          width: MediaQuery.of(context).size.width,
          child: DataTable(
            columns:  <DataColumn>[
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
                    'Question Title',
                    style: TextStyle(fontStyle: FontStyle.italic),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Created At',
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
            rows:questions==null?[RowEmpty()]:
            questions!
                .map((question) => DataRow(cells: [
              DataCell(Text(question.id!)),
              DataCell(Text(question.title!)),
              DataCell(Text(question.created_at.toString())),
              DataCell(IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ])).toList(),
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
                  child: SingleChildScrollView(
                    padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
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
                )),
          ],
        ),
      ),
    );


  }

}

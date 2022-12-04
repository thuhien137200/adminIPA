import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../model/data_topic.dart';
import '../../style/style.dart';


class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late Future<List<Topic>?> _dataFuture;

  List<Topic>? _topicsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Topic.fromDocumentSnapshot(documentSnapshot);
      }
      return Topic.test();
    }).toList();
  }


  Row HeaderTopic()
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
                      text: 'Topic',
                      size: 30,
                      fontWeight: FontWeight.w800),
                  PrimaryText(
                    text: 'Manage All Topic',
                    size: 16,
                    fontWeight: FontWeight.w400,
                    color: Color(0xffa6a6a6),
                  )
                ]),
          ),
          Spacer(
            flex: 1,
          ),
          IconButton(onPressed: (){}, icon: Icon(Icons.add))
        ]);
  }

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }



  void removeTopict()
  {
    //dosomething
  }
  Widget DataTableTopic()
  {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Topic>?> snapshot) {
        List<Topic>? topics = snapshot.data;
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
                    'Topic Name',
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
            rows:topics==null?[RowEmpty()]:
            topics!
                .map((topic) => DataRow(cells: [
              DataCell(Text(topic.topic_id!)),
              DataCell(Text(topic.topic_name!)),
              DataCell(IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ])).toList(),
          ),
        );
      },
    );
  }

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture = _db.collection('topic').get().then(_topicsFromQuerySnapshot);
    super.initState();
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
                        HeaderTopic(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        DataTableTopic()
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

import 'package:admin_ipa/screens/topic/TopicData.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../model/data_topic.dart';
import '../../services/database_service.dart';
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
    List<Topic>? res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Topic.fromDocumentSnapshot(documentSnapshot);
      }
      return Topic.test();
    }).toList();
    TopicData.topicData = res ?? [];
    return res;
  }

  Row HeaderTopic() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Topic',
                size: 30,
                fontWeight: FontWeight.w800,
                color: ColorController().getColor().colorText,
              ),
              PrimaryText(
                text: 'Manage All Topic',
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
          icon: Icon(
            Icons.add,
            color: ColorController().getColor().colorText,
          ))
    ]);
  }

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
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

  void removeTopict() {
    //dosomething
  }
  Widget DataTableTopic() {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Topic>?> snapshot) {
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
                    'Topic Name',
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
              DataColumn(
                label: Expanded(
                  child: Text(
                    '',
                  ),
                ),
              ),
            ],
            rows: TopicData.topicData == null
                ? [RowEmpty()]
                : TopicData.topicData
                    .map((topic) => DataRow(cells: [
                          DataCell(Text(
                            topic.topic_id!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Text(
                            topic.topic_name!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(IconButton(
                              //Delete function
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text(
                                          'Delete Topic Post',
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
                                                DatabaseService().deletePost(
                                                    topic.topic_id ?? 'null');
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
                          DataCell(IconButton(
                              // Modify function
                              onPressed: () {
                                var topicController = TextEditingController();
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String content = "";
                                      var topicNameController =
                                          TextEditingController();
                                      topicNameController.text =
                                          topic.topic_name ?? 'Null';

                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text(
                                          'Modify Experience Post',
                                          style: AppFonts.headStyle,
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            child: Column(
                                              children: <Widget>[
                                                Container(
                                                  width: 500,
                                                  padding:
                                                      const EdgeInsets.only(
                                                          bottom: 16),
                                                  child: TextFormField(     
                                                    decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.lightBlue[100],
                                                      //icon: Icon(Icons.account_box),
                                                    ),
                                                    style: AppFonts.content,
                                                    controller:
                                                        topicNameController,
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: Text("Cancel"),
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                              child: Text("Submit"),
                                              onPressed: () {
                                                DatabaseService().modifyTopic(
                                                    topic.topic_id ?? 'null',
                                                    topicNameController.text);

                                                Navigator.pop(context);
                                              })
                                        ],
                                      );
                                    });
                              },
                              icon: Icon(
                                CupertinoIcons.pen,
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
                  child: Container(
                color: ColorController().getColor().colorBody,
                height: MediaQuery.of(context).size.height,
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      HeaderTopic(),
                      SizedBox(
                        height: SizeConfig.blockSizeVertical * 2.5,
                      ),
                      DataTableTopic(),
                    ],
                  ),
                ),
              )),
            )
          ],
        ),
      ),
    );
  }
}

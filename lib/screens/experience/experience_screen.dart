import 'dart:convert';

import 'package:admin_ipa/screens/experience/DataExperience.dart';
import 'package:admin_ipa/services/database_service.dart';
import 'package:admin_ipa/services/experience_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../model/data_experience.dart';
import '../../model/data_topic.dart';
import '../../style/style.dart';

class ExperienceScreen extends StatefulWidget {
  const ExperienceScreen({Key? key}) : super(key: key);

  @override
  State<ExperienceScreen> createState() => _ExperienceScreenState();
}

class _ExperienceScreenState extends State<ExperienceScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  var topicController= TextEditingController();
  late Future<List<ExperiencePost>?> _dataFuture;
  final _formKey = GlobalKey<FormState>();
  late Future<List<Topic>?> _topicFuture;
   String topicId ='';

  List<ExperiencePost>? _experienceFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<ExperiencePost>? res= querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
    DataExperience.dataExperience=res??[];
    return res;
  }

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture =
        _db.collection('experience').get().then(_experienceFromQuerySnapshot);
    _topicFuture = _db.collection('topic').get().then(_topicsFromQuerySnapshot);
    super.initState();
  }

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

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  Container topicSelection(Topic topic) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: Color.fromARGB(255, 105, 179, 240),
      ),
      child: InkWell(
        onTap: (){
          setState(() {
            topicController.text=(topic.topic_name??'Null') ;
            //topicName=topic.topic_name??'Null';
            topicId=topic.idTopic;
            print(topicId);
          });
        },
        child: Text(topic.topic_name ?? 'null')
        ),
    );
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
          onPressed: () async {
            var topics = await _topicFuture;
            //print('Topic: ${topics?.length ?? 0}');
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String content = "";
                  var titleController = TextEditingController();
                  var contentController = TextEditingController();
                  
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Add Experience Post'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Row(
                              children: [
                                ...(topics!.map((e) => topicSelection(e))),
                              ],
                            ),

                            TextFormField(
                               decoration: InputDecoration(
                                labelText: 'Topic',
                                //icon: Icon(Icons.account_box),
                              ),
                              controller: topicController,
                            ),

                            TextFormField(
                              decoration: InputDecoration(
                                labelText: 'Title',
                                //icon: Icon(Icons.account_box),
                              ),
                              controller: titleController,
                            ),
                            Container(
                              height: 10 * 24.0,
                              child: TextField(
                                controller: contentController,
                                maxLines: 10,
                                decoration: InputDecoration(
                                  hintText: "Content",
                                  fillColor: Colors.lightBlue[100],
                                  filled: true,
                                ),
                                onChanged: (value) {
                                  content = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    actions: [
                      TextButton(
                        child: Text("Cancel"),
                        onPressed: () => Navigator.pop(context),
                      ),
                      TextButton(
                          child: Text("Submit"),
                          onPressed: () {
                            ExperiencePost experiencePost =
                                ExperiencePost(
                                  null,
                                  topicId,
                                  titleController.text,
                                  DateTime.now(),
                                  contentController.text,
                                  null,
                                  null,
                                  false
                                );
                                print(experiencePost.toString());
                            // experiencePost.setContent(contentController.text);
                            // experiencePost.setTitle(titleController.text);
                            // experiencePost.setCreated_at(DateTime.now());
                            // ExperiencePost.fromJson(
                            //     jsonDecode(jsonEncode(experiencePost)));
                            DatabaseService().addExperiencePost(experiencePost);
                            
                            Navigator.pop(context);
                          })
                    ],
                  );
                });
          },
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
                    'Delete', style: textStyleTableHeader()
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Edit',
                      style: textStyleTableHeader()
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Apporve',
                      style: textStyleTableHeader()
                  ),
                ),
              )
            ],
            rows: DataExperience.dataExperience == null
                ? [RowEmpty()]
                : DataExperience.dataExperience
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
                            post.created_at.toString(),
                            style: textStyleTableContent(),
                          )),
                          DataCell(IconButton(
                              onPressed: () {},
                              icon: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: ColorController().getColor().colorText,
                              ))),
                          DataCell(IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.pen,
                    color: ColorController().getColor().colorText,
                  ))),

                          DataCell(
                              post.isApproved!?Text(''):
                              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    CupertinoIcons.check_mark,
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

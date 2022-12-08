import 'package:admin_ipa/screens/article/data_article.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../model/data_article.dart';
import '../../services/articles_service.dart';
import '../../services/database_service.dart';
import '../../style/style.dart';

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();

  late Future<List<ArticlePost>?> _dataFuture;

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture =
        _db.collection('articles').get().then(_articlesFromQuerySnapshot);
    super.initState();
  }

  List<ArticlePost>? _articlesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<ArticlePost>? result= querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ArticlePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ArticlePost.test();
    }).toList();
    DataArticle.dataArticle=result?? [];
    return result;
  }

  Row HeaderArticle() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Article',
                size: 30,
                fontWeight: FontWeight.w800,
                color: ColorController().getColor().colorText,
              ),
              PrimaryText(
                text: 'Manage All Article post',
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
          onPressed: () {

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String content = "";
                  var titleController = TextEditingController();
                  var contentController = TextEditingController();
                  
                  return AlertDialog(
                    scrollable: true,
                    title: Text('Add Article Post'),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
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
                            ArticlePost articlePost =
                                ArticlePost(
                                  null,
                                  titleController.text,
                                  DateTime.now(),
                                  contentController.text,
                                  null,
                                  'JOcWUTwArybiZjO9CelOhvBApCT2',
                                  null,
                                );
                                print(articlePost.toString());
                            // experiencePost.setContent(contentController.text);
                            // experiencePost.setTitle(titleController.text);
                            // experiencePost.setCreated_at(DateTime.now());
                            // ExperiencePost.fromJson(
                            //     jsonDecode(jsonEncode(experiencePost)));
                            DatabaseService().addArticle(articlePost);
                            
                            Navigator.pop(context);
                          })
                    ],
                  );
                });
          },
          icon: Icon(
            Icons.add,
            color: ColorController().getColor().colorText,
          ))
    ]);
  }

  void removeArtice() {
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

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  Widget DataTableArticle() {
    return FutureBuilder(
      future: _dataFuture,
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
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
                    'Article Title',
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
              DataColumn(
                label: Expanded(
                  child: Text(
                    '',
                  ),
                ),
              ),
            ],
            rows: DataArticle.dataArticle == null
                ? [RowEmpty()]
                : DataArticle.dataArticle
                    .map((article) => DataRow(cells: [
                          DataCell(Text(
                            article.id!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Text(
                            article.title!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Text(
                            article.created_at.toString(),
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
                          HeaderArticle(),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2.5,
                          ),
                          DataTableArticle()
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

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
    List<ArticlePost>? result = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ArticlePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ArticlePost.test();
    }).toList();
    DataArticle.dataArticle = result ?? [];
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
            late ArticlePost articlePost;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String content = "";
                  var titleController = TextEditingController();
                  var contentController = TextEditingController();

                  return AlertDialog(
                    scrollable: true,
                    title: Text(
                      'Add an Article',
                      style: AppFonts.headStyle,
                    ),
                    content: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Form(
                        child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Title',
                                    style: AppFonts.title,
                                  ),
                                ]),
                            Container(
                              width: 500,
                              padding: EdgeInsets.only(bottom: 16),
                              child: TextFormField(
                                decoration: InputDecoration(
                                  fillColor: Colors.lightBlue[100],
                                  //icon: Icon(Icons.account_box),
                                ),
                                style: AppFonts.content,
                                controller: titleController,
                              ),
                            ),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Text(
                                    'Content',
                                    style: AppFonts.title,
                                  ),
                                ]),
                            Container(
                              padding: EdgeInsets.only(top: 16),
                              height: 10 * 24.0,
                              child: TextField(
                                controller: contentController,
                                maxLines: 10,
                                style: AppFonts.content,
                                decoration: InputDecoration(
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
                            if (contentController.text == '' ||
                                titleController.text == '') {
                              var snackBar = const SnackBar(
                                  content: Text(
                                      'Title Or Content does not allow null'));
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(snackBar);
                              return;
                            }

                            ArticlePost articlePost = ArticlePost(
                              null,
                              titleController.text,
                              DateTime.now(),
                              contentController.text,
                              null,
                              'JOcWUTwArybiZjO9CelOhvBApCT2',
                              null,
                            );
                            print(articlePost.toString());
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
                              onPressed: () {
                                setState(() {
                                  showDialog(
                                      context: context,
                                      builder: (BuildContext context) {
                                        return AlertDialog(
                                          scrollable: true,
                                          title: Text(
                                            'Notice',
                                            style: AppFonts.headStyle,
                                          ),
                                          content: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Are you sure you want to delete this Article ?',
                                                  style: AppFonts.title,
                                                ),
                                              ]),
                                          actions: [
                                            TextButton(
                                              child: Text("No"),
                                              onPressed: () =>
                                                  Navigator.pop(context),
                                            ),
                                            TextButton(
                                                child: Text("Yes"),
                                                onPressed: () {
                                                  DataArticle.deletePost(
                                                      article.id!);
                                                  DatabaseService()
                                                      .deleteArticle(
                                                          article.id!);
                                                  Navigator.pop(context);
                                                })
                                          ],
                                        );
                                      });
                                });
                              },
                              icon: Icon(
                                CupertinoIcons.xmark_circle_fill,
                                color: ColorController().getColor().colorText,
                              ))),
                          DataCell(IconButton(
                              // Sua
                              onPressed: () {
                                showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      String content = "";
                                      var titleController =
                                          TextEditingController();
                                      var contentController =
                                          TextEditingController();
                                      titleController.text =
                                          article.title ?? 'Null';
                                      contentController.text =
                                          article.content ?? 'Null';

                                      return AlertDialog(
                                        scrollable: true,
                                        title: Text(
                                          'Edit information',
                                          style: AppFonts.headStyle,
                                        ),
                                        content: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Form(
                                            child: Column(
                                              children: <Widget>[
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Title',
                                                        style: AppFonts.title,
                                                      ),
                                                    ]),
                                                Container(
                                                  width: 500,
                                                  padding: EdgeInsets.only(
                                                      bottom: 16),
                                                  child: TextFormField(
                                                    decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.lightBlue[100],
                                                      //icon: Icon(Icons.account_box),
                                                    ),
                                                    style: AppFonts.content,
                                                    controller: titleController,
                                                  ),
                                                ),
                                                Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        'Content',
                                                        style: AppFonts.title,
                                                      ),
                                                    ]),
                                                Container(
                                                  padding:
                                                      EdgeInsets.only(top: 16),
                                                  height: 10 * 24.0,
                                                  child: TextField(
                                                    controller:
                                                        contentController,
                                                    maxLines: 10,
                                                    style: AppFonts.content,
                                                    decoration: InputDecoration(
                                                      fillColor:
                                                          Colors.lightBlue[100],
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
                                            onPressed: () =>
                                                Navigator.pop(context),
                                          ),
                                          TextButton(
                                              child: Text("Submit"),
                                              onPressed: () {
                                                // ArticlePost articlePost = ArticlePost(
                                                //   null,
                                                //   titleController.text,
                                                //   DateTime.now(),
                                                //   contentController.text,
                                                //   null,
                                                //   'JOcWUTwArybiZjO9CelOhvBApCT2',
                                                //   null,
                                                // );
                                                // print(articlePost.toString());
                                                DatabaseService()
                                                    .modifyTitleAndContentArticle(
                                                        article.id ?? 'null',
                                                        titleController.text,
                                                        contentController.text);

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

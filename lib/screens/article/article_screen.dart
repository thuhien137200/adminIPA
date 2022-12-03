import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../model/data_article.dart';
import '../../services/articles_service.dart';
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
    _dataFuture = _db.collection('articles').get().then(_articlesFromQuerySnapshot);
    super.initState();
  }

  List<ArticlePost>? _articlesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ArticlePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ArticlePost.test();
    }).toList();
  }

  Row HeaderArticle()
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
                      text: 'Article',
                      size: 30,
                      fontWeight: FontWeight.w800),
                  PrimaryText(
                    text: 'Manage All Article post',
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

  void removeArtice()
  {
    //dosomething
  }

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  Widget DataTableArticle()
  {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
        List<ArticlePost>? articles = snapshot.data;
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
                    'Article Title',
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
            rows:articles==null?[RowEmpty()]:
            articles!
                .map((article) => DataRow(cells: [
              DataCell(Text(article.id!)),
              DataCell(Text(article.title!)),
              DataCell(Text(article.created_at.toString())),
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
                        HeaderArticle(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        DataTableArticle()
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


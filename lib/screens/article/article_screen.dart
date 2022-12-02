import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../style/style.dart';



class ArticleScreen extends StatefulWidget {
  const ArticleScreen({Key? key}) : super(key: key);

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
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
  Container DataTableArticle()
  {
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
        rows:  <DataRow>[
          DataRow(
            cells: <DataCell>[
              DataCell(Text('1')),
              DataCell(Text('How to do this one?')),
              DataCell(Text('25/11/2022')),
              DataCell(IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('2')),
              DataCell(Text('Flutter is so amazing')),
              DataCell(Text('27/11/2022')),
              DataCell(IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.xmark_circle_fill))),
            ],
          ),
          DataRow(
            cells: <DataCell>[
              DataCell(Text('3')),
              DataCell(Text('Is C++ important?')),
              DataCell(Text('27/11/2022')),
              DataCell(IconButton(onPressed: (){}, icon: Icon(CupertinoIcons.xmark_circle_fill))),
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


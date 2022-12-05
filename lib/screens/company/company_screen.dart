import 'package:admin_ipa/model/data_company.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../controller/color_theme_controller.dart';
import '../../style/style.dart';

class CompanyScreen extends StatefulWidget {
  const CompanyScreen({Key? key}) : super(key: key);

  @override
  State<CompanyScreen> createState() => _CompanyScreenState();
}

class _CompanyScreenState extends State<CompanyScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late Future<List<Company>?> _dataFuture;

  List<Company>? _companiesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Company.fromDocumentSnapshot(documentSnapshot);
      }
      return Company.test();
    }).toList();
  }

  Row HeaderCompany() {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      SizedBox(
        child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              PrimaryText(
                text: 'Company',
                size: 30,
                fontWeight: FontWeight.w800,
                color: ColorController().getColor().colorText,
              ),
              PrimaryText(
                text: 'Manage All Company Detail',
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

  void removeCompany() {
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

  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    _dataFuture =
        _db.collection('companies').get().then(_companiesFromQuerySnapshot);
    super.initState();
  }

  Widget DataTableCompany() {
    return FutureBuilder(
      future: _dataFuture,
      builder: (BuildContext context, AsyncSnapshot<List<Company>?> snapshot) {
        List<Company>? companies = snapshot.data;
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
                    'Name',
                    style: textStyleTableHeader(),
                  ),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text(
                    'Image',
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
            rows: companies == null
                ? [RowEmpty()]
                : companies!
                    .map((company) => DataRow(cells: [
                          DataCell(Text(
                            company.id!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Text(
                            company.name!,
                            style: textStyleTableContent(),
                          )),
                          DataCell(Container(
                            height: MediaQuery.of(context).size.height / 9 - 20,
                            width: MediaQuery.of(context).size.height / 9 + 30,
                            margin: EdgeInsets.symmetric(vertical: 10),
                            decoration: BoxDecoration(
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.circular(16),
                                color: ColorController().getColor().colorBox),
                            child: Center(
                                child: Image(
                              image: NetworkImage(company.logoUrl!),
                              height: MediaQuery.of(context).size.height / 9,
                              width: MediaQuery.of(context).size.width / 10,
                            )),
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
                        HeaderCompany(),
                        SizedBox(
                          height: SizeConfig.blockSizeVertical * 2.5,
                        ),
                        DataTableCompany()
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

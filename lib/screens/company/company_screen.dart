import 'dart:html';

import 'package:admin_ipa/model/data_company.dart';
import 'package:admin_ipa/screens/company/data_company.dart';
import 'package:admin_ipa/services/database_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
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
  String imgUrl = '';
  List<Company>? _companiesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<Company>? res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Company.fromDocumentSnapshot(documentSnapshot);
      }
      return Company.test();
    }).toList();
    DataCompany.companyData = res ?? [];
    return res;
  }

  uploadToStorage() {
    var input = FileUploadInputElement()..accept = 'image/*';
    FirebaseStorage fs = FirebaseStorage.instance;
    input.click();
    input.onChange.listen((event) {
      final file = input.files?.first;
      final reader = FileReader();
      reader.readAsDataUrl(file!);
      reader.onLoadEnd.listen((event) async {
        var snapshot = await fs.ref().child(file!.name).putBlob(file);

        String downloadUrl = await snapshot.ref.getDownloadURL();
        setState(() {
          imgUrl = downloadUrl;
          print(imgUrl);
        });
      });
    });
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
          onPressed: () {
            late Company company;
            showDialog(
                context: context,
                builder: (BuildContext context) {
                  String name = "";
                  String logoUrl = "";
                  var nameController = TextEditingController();
                  var logoUrlController = TextEditingController();

                  return AlertDialog(
                    scrollable: true,
                    title: Text(
                      'Add new Company',
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
                                    'Name',
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
                                controller: nameController,
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                FlatButton(
                                    onPressed: () {
                                      uploadToStorage();
                                    },
                                    child: Container(
                                      decoration: BoxDecoration(
                                          color: Colors.blueAccent),
                                      child: Text(
                                        'Upload Image',
                                        style: AppFonts.title,
                                      ),
                                    )),
                              ],
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
                            Company company = Company(
                              null,
                              nameController.text,
                              imgUrl,
                            );
                            DatabaseService().addCompany(company);

                            Navigator.pop(context);
                          })
                    ],
                  );
                });
          },
          icon: Icon(Icons.add, color: ColorController().getColor().colorText))
    ]);
  }

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("")),
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
                    'Modify',
                    style: textStyleTableHeader(),
                  ),
                ),
              ),
            ],
            rows: DataCompany.companyData == null
                ? [RowEmpty()]
                : DataCompany.companyData!
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
                          DataCell(Row(
                            children: [
                              IconButton(
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
                                                      'Are you sure you want to delete this Company ?',
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
                                                      DatabaseService()
                                                          .deleteCompany(
                                                          company.id!);
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
                                  )),
                              IconButton(
                                  onPressed: () {
                                    showDialog(
                                        context: context,
                                        builder: (BuildContext context) {
                                          String content = "";
                                          var nameController =
                                          TextEditingController();
                                          var logoUrlController =
                                          TextEditingController();
                                          nameController.text =
                                              company.name ?? 'Null';
                                          logoUrlController.text =
                                              company.logoUrl ?? 'Null';

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
                                                            'Name',
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
                                                        ),
                                                        style: AppFonts.content,
                                                        controller: nameController,
                                                      ),
                                                    ),
                                                    Row(
                                                        mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            'Logo Url',
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
                                                        ),
                                                        style: AppFonts.content,
                                                        controller:
                                                        logoUrlController,
                                                      ),
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                      children: [
                                                        FlatButton(
                                                            onPressed: () {
                                                              uploadToStorage();
                                                            },
                                                            child: Container(
                                                              decoration:
                                                              BoxDecoration(
                                                                  color: Colors
                                                                      .blueAccent),
                                                              child: Text(
                                                                'Upload Image',
                                                                style:
                                                                AppFonts.title,
                                                              ),
                                                            )),
                                                      ],
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
                                                    DatabaseService()
                                                        .modifyCompanyInformation(
                                                        company.id ?? 'null',
                                                        nameController.text,
                                                        imgUrl.compareTo('') ==
                                                            0
                                                            ? logoUrlController
                                                            .text
                                                            : imgUrl);
                                                    Navigator.pop(context);
                                                  })
                                            ],
                                          );
                                        });
                                  },
                                  icon: Icon(
                                    CupertinoIcons.pen,
                                    color: ColorController().getColor().colorText,
                                  ))
                            ],
                          )),
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

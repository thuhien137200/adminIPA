import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/quizzes/component/style_table.dart';
import 'package:admin_ipa/screens/quizzes/controller/quizzes_controller.dart';
import 'package:admin_ipa/services/quizzes_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../../../model/data_quizzes.dart';

class CustomBoxAddInfomation extends StatelessWidget {
  const CustomBoxAddInfomation({Key? key, required this.padding})
      : super(key: key);
  final double padding;

  @override
  Widget build(BuildContext context) {
    if (QuizzesController.selected == 1) return boxCategories();
    return boxJob();
  }

  void messages(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Padding boxJob() {
    TextEditingController nameController = TextEditingController();
    return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorController().getColor().colorBody),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Job name: ", style: StyleTable().textStyleTableHeader()),
              inputText(nameController, "Enter the job name"),
              textTimeCreated(),
              Align(
                  child: GestureDetector(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          messages("Job name isn't EMPTY");
                        } else {
                          FirebaseFirestore _db = FirebaseFirestore.instance;
                          CollectionReference collection =
                              _db.collection('quizzes');
                          Map<String, dynamic> data = {
                            'jobs': nameController.text,
                            'time_created': Timestamp.now()
                          };
                          QuizzesServices()
                              .addData(collection, data, "Add to successfully");
                        }
                      },
                      child: customButtonAdd()))
            ])));
  }

  Padding boxCategories() {
    TextEditingController nameController = TextEditingController();
    return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorController().getColor().colorBody),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Category name: ",
                  style: StyleTable().textStyleTableHeader()),
              inputText(nameController, "Enter the category name"),
              textTimeCreated(),
              Align(
                  child: GestureDetector(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          messages("category name isn't EMPTY");
                        } else {
                          FirebaseFirestore _db = FirebaseFirestore.instance;
                          CollectionReference collection = _db
                              .collection('quizzes')
                              .doc(QuizzesController.jobId)
                              .collection('categories');
                          Map<String, dynamic> data = {
                            'name': nameController.text,
                            'time_created': Timestamp.now()
                          };
                          QuizzesServices()
                              .addData(collection, data, "Add to successfully");
                        }
                      },
                      child: customButtonAdd()))
            ])));
  }

  Container inputText(TextEditingController nameController, String st) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: boxDecoration(),
      child: Align(
        child: TextField(
          controller: nameController,
          style: TextStyle(color: ColorController().getColor().colorText),
          // obscureText: true,
          decoration: InputDecoration(
              hintText: st,
              hintStyle: TextStyle(
                  color:
                      ColorController().getColor().colorText.withOpacity(0.5)),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Row textTimeCreated() {
    return Row(
      children: [
        Text("Time created: ", style: StyleTable().textStyleTableHeader()),
        Text(Timestamp.now().toDate().toString(),
            style: StyleTable().textStyleTableContent()),
      ],
    );
  }

  Container customButtonAdd() {
    return Container(
      height: 50,
      width: 100,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          // color: Colors.amber[50],
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(212, 163, 196, 0.5),
                Color.fromRGBO(168, 209, 231, 0.5)
              ])),
      child: Align(
        child: Text(
          "Add",
          style: StyleTable().textStyleTableContent(),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() => BoxDecoration(
        color: ColorController().getColor().colorBox,
        borderRadius: BorderRadius.circular(5),
      );
}

class CustomBoxUpdateInfomation extends StatelessWidget {
  const CustomBoxUpdateInfomation(
      {Key? key,
      required this.padding,
      required this.job,
      required this.categories,
      required this.documentReference})
      : super(key: key);
  final double padding;
  final Job job;
  final Categories categories;
  final DocumentReference documentReference;
  @override
  Widget build(BuildContext context) {
    if (QuizzesController.selected == 1) return boxCategories();
    return boxJob();
  }

  void messages(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Padding boxJob() {
    TextEditingController nameController = TextEditingController();
    nameController.text = job.name ?? "";
    return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorController().getColor().colorBody),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Job name: ", style: StyleTable().textStyleTableHeader()),
              inputText(nameController, "Enter the job name"),
              textTimeCreated(job.time_created!),
              Align(
                  child: GestureDetector(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          messages("Job name isn't EMPTY");
                        } else {
                          FirebaseFirestore _db = FirebaseFirestore.instance;
                          CollectionReference collection =
                              _db.collection('quizzes');
                          Map<String, dynamic> data = {
                            'jobs': nameController.text,
                            'time_updated': Timestamp.now()
                          };
                          QuizzesServices().updateData(documentReference, data,
                              "Updated to successfully");
                        }
                      },
                      child: customButtonUpdate()))
            ])));
  }

  Padding boxCategories() {
    TextEditingController nameController = TextEditingController();
    nameController.text = categories.name ?? "";
    return Padding(
        padding: EdgeInsets.only(left: padding),
        child: Container(
            height: 200,
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: ColorController().getColor().colorBody),
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text("Category name: ",
                  style: StyleTable().textStyleTableHeader()),
              inputText(nameController, "Enter the category name"),
              textTimeCreated(categories.time_created!),
              Align(
                  child: GestureDetector(
                      onTap: () {
                        if (nameController.text.isEmpty) {
                          messages("category name isn't EMPTY");
                        } else {
                          Map<String, dynamic> data = {
                            'name': nameController.text,
                            'time_created': Timestamp.now()
                          };
                          QuizzesServices().updateData(documentReference, data,
                              "Update to successfully");
                        }
                      },
                      child: customButtonUpdate()))
            ])));
  }

  Container inputText(TextEditingController nameController, String st) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
      height: 30,
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: boxDecoration(),
      child: Align(
        child: TextField(
          controller: nameController,
          style: TextStyle(color: ColorController().getColor().colorText),
          // obscureText: true,
          decoration: InputDecoration(
              hintText: st,
              hintStyle: TextStyle(
                  color:
                      ColorController().getColor().colorText.withOpacity(0.5)),
              border: InputBorder.none),
        ),
      ),
    );
  }

  Row textTimeCreated(DateTime dt) {
    return Row(
      children: [
        Text("Time created: ", style: StyleTable().textStyleTableHeader()),
        Text(dt.toString(), style: StyleTable().textStyleTableContent()),
      ],
    );
  }

  Container customButtonUpdate() {
    return Container(
      height: 50,
      width: 100,
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
          // color: Colors.amber[50],
          borderRadius: BorderRadius.circular(5),
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color.fromRGBO(212, 163, 196, 0.5),
                Color.fromRGBO(168, 209, 231, 0.5)
              ])),
      child: Align(
        child: Text(
          "Save",
          style: StyleTable().textStyleTableContent(),
        ),
      ),
    );
  }

  BoxDecoration boxDecoration() => BoxDecoration(
        color: ColorController().getColor().colorBox,
        borderRadius: BorderRadius.circular(5),
      );
}

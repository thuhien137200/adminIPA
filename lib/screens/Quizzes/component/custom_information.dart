import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/quizzes/component/overview.dart';
import 'package:admin_ipa/screens/quizzes/component/style_table.dart';
import 'package:admin_ipa/screens/quizzes/controller/quizzes_controller.dart';
import 'package:admin_ipa/services/quizzes_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/data_quizzes.dart';
import 'custom_box_information.dart';

class CustomTable extends StatefulWidget {
  const CustomTable({Key? key}) : super(key: key);

  @override
  State<CustomTable> createState() => _CustomTableState();
}

class _CustomTableState extends State<CustomTable> {
  static List<Job> listJob = [];
  static List<Categories> listCategories = [];
  static List<SetOfQuiz> listSetOfQuiz = [];
  static int selectTable = 0;

  @override
  Widget build(BuildContext context) {
    if (selectTable == 1) return tableInformationCategories();
    if (selectTable == 2) return tableInformationSetOfQuiz();
    return tableInformationJob();
  }

  Column tableInformationSetOfQuiz() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              GestureDetector(
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: ColorController().getColor().colorText),
                  onTap: () {
                    setState(() {
                      selectTable = 1;
                    });
                  }),
              Text("  Set of Quiz", style: StyleTable().textStyleHeader()),
              Spacer(),
              GestureDetector(
                onTap: () {
                  QuizzesController.key.currentState!.openEndDrawer();
                },
                child: Icon(Icons.add,
                    color: ColorController().getColor().colorText, size: 32),
              )
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  dataTextStyle: StyleTable().textStyleTableContent(),
                  headingTextStyle: StyleTable().textStyleTableHeader(),
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Quiz name')),
                    DataColumn(label: Text('Time created')),
                    DataColumn(label: Text('Number of question')),
                    DataColumn(label: Text('Option'))
                  ],
                  rows: listSetOfQuiz.isEmpty
                      ? [StyleTable().RowEmpty()]
                      : listSetOfQuiz
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.name ?? "")),
                                DataCell(Text(e.time_created.toString())),
                                DataCell(Text(e.number_question.toString())),
                                DataCell(Row(children: [
                                  Icon(Icons.edit_outlined,
                                      color: ColorController()
                                          .getColor()
                                          .colorText),
                                  Icon(Icons.highlight_off_rounded,
                                      color: ColorController()
                                          .getColor()
                                          .colorText),
                                ]))
                              ]))
                          .toList()))
        ]);
  }

  Column tableInformationCategories() {
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(mainAxisAlignment: MainAxisAlignment.start, children: [
            GestureDetector(
                child: Icon(Icons.arrow_back_ios_new_rounded,
                    color: ColorController().getColor().colorText),
                onTap: () {
                  setState(() {
                    selectTable = 0;
                  });
                }),
            Text("  Categories", style: StyleTable().textStyleHeader()),
            Spacer(),
            GestureDetector(
              onTap: () {
                _settingModalBottomSheet(context);
              },
              child: Icon(Icons.add,
                  color: ColorController().getColor().colorText, size: 32),
            )
          ]),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  dataTextStyle: StyleTable().textStyleTableContent(),
                  headingTextStyle: StyleTable().textStyleTableHeader(),
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Categories name')),
                    DataColumn(label: Text('Time created')),
                    DataColumn(label: Text('Number set of quiz')),
                    DataColumn(label: Text('Option'))
                  ],
                  rows: listCategories.length == 0
                      ? [StyleTable().RowEmpty()]
                      : listCategories
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.name ?? "")),
                                DataCell(Text(e.time_created.toString())),
                                DataCell(Text(e.number_quiz.toString())),
                                DataCell(Row(children: [
                                  Icon(Icons.edit_outlined,
                                      color: ColorController()
                                          .getColor()
                                          .colorText),
                                  Icon(Icons.highlight_off_rounded,
                                      color: ColorController()
                                          .getColor()
                                          .colorText),
                                  InkWell(
                                      child: Icon(Icons.navigate_next_rounded,
                                          color: ColorController()
                                              .getColor()
                                              .colorText),
                                      onTap: () {
                                        setState(() {
                                          listSetOfQuiz = e.listquiz ?? [];
                                          QuizzesController.categoriesId =
                                              e.id ?? "";
                                          QuizzesController.selected = 2;
                                          selectTable = 2;
                                        });
                                      })
                                ]))
                              ]))
                          .toList()))
        ]);
  }

  Column tableInformationJob() {
    listJob = OverviewQuiz.listJob;
    return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Job", style: StyleTable().textStyleHeader()),
              GestureDetector(
                onTap: () {},
                child: GestureDetector(
                  onTap: () {
                    _settingModalBottomSheet(context);
                  },
                  child: GestureDetector(
                    onTap: () {
                      _settingModalBottomSheet(context);
                    },
                    child: Icon(Icons.add,
                        color: ColorController().getColor().colorText,
                        size: 32),
                  ),
                ),
              )
            ],
          ),
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  dataTextStyle: StyleTable().textStyleTableContent(),
                  headingTextStyle: StyleTable().textStyleTableHeader(),
                  columns: const <DataColumn>[
                    DataColumn(label: Text('Job name')),
                    DataColumn(label: Text('Time created')),
                    DataColumn(label: Text('Number of categories')),
                    DataColumn(label: Text('Option'))
                  ],
                  rows: listJob.isEmpty
                      ? [StyleTable().RowEmpty()]
                      : listJob
                          .map((e) => DataRow(cells: [
                                DataCell(Text(e.name ?? "")),
                                DataCell(Text(e.time_created.toString())),
                                DataCell(Text(e.number_categories.toString())),
                                DataCell(Row(children: [
                                  Icon(Icons.edit_outlined,
                                      color: ColorController()
                                          .getColor()
                                          .colorText),
                                  Icon(Icons.highlight_off_rounded,
                                      color: ColorController()
                                          .getColor()
                                          .colorText),
                                  InkWell(
                                      child: Icon(Icons.navigate_next_rounded,
                                          color: ColorController()
                                              .getColor()
                                              .colorText),
                                      onTap: () {
                                        setState(() {
                                          listCategories = e.categories ?? [];
                                          QuizzesController.jobId = e.id ?? "";
                                          QuizzesController.selected = 1;
                                          selectTable = 1;
                                        });
                                      })
                                ]))
                              ]))
                          .toList()))
        ]);
  }

  void _settingModalBottomSheet(context) {
    double padding = (MediaQuery.of(context).size.width - 500) > 0
        ? (MediaQuery.of(context).size.width - 500)
        : 0;
    showModalBottomSheet(
        context: context,
        backgroundColor: Colors.transparent,
        builder: (BuildContext bc) {
          return CustomBoxInfomation(
            padding: padding,
          );
        });
  }
}

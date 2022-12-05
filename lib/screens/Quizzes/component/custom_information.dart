import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/quizzes/component/overview.dart';
import 'package:admin_ipa/services/quizzes_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/data_quizzes.dart';

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
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorController().getColor().colorText,
              ),
              onTap: () {
                setState(() {
                  selectTable = 1;
                });
              },
            ),
            Text(
              "  Set of Quiz",
              style: textStyleHeader(),
            ),
            Spacer(),
            Icon(
              Icons.add,
              color: ColorController().getColor().colorText,
              size: 32,
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataTextStyle: textStyleTableContent(),
            headingTextStyle: textStyleTableHeader(),
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Quiz name'),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Time created'),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Number of question'),
                ),
              ),
              DataColumn(
                  label: Expanded(
                child: Text('Option'),
              )),
            ],
            rows: listSetOfQuiz.length == 0
                ? [RowEmpty()]
                : listCategories
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.name ?? "")),
                          DataCell(Text(e.time_created.toString())),
                          DataCell(Text(e.number_quiz.toString())),
                          DataCell(Row(
                            children: [
                              Spacer(),
                              Icon(Icons.edit_outlined,
                                  color:
                                      ColorController().getColor().colorText),
                            ],
                          ))
                        ]))
                    .toList(),
          ),
        )
      ],
    );
  }

  Column tableInformationCategories() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            GestureDetector(
              child: Icon(
                Icons.arrow_back_ios_new_rounded,
                color: ColorController().getColor().colorText,
              ),
              onTap: () {
                setState(() {
                  selectTable = 0;
                });
              },
            ),
            Text(
              "  Categories",
              style: textStyleHeader(),
            ),
            Spacer(),
            Icon(
              Icons.add,
              color: ColorController().getColor().colorText,
              size: 32,
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataTextStyle: textStyleTableContent(),
            headingTextStyle: textStyleTableHeader(),
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Categories name'),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Time created'),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Number set of quiz'),
                ),
              ),
              DataColumn(
                  label: Expanded(
                child: Text('Option'),
              )),
            ],
            rows: listCategories.length == 0
                ? [RowEmpty()]
                : listCategories
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.name ?? "")),
                          DataCell(Text(e.time_created.toString())),
                          DataCell(Text(e.number_quiz.toString())),
                          DataCell(Row(
                            children: [
                              Spacer(),
                              Icon(Icons.edit_outlined,
                                  color:
                                      ColorController().getColor().colorText),
                              // (e.number_quiz ?? 0) > 0 ?
                              InkWell(
                                child: Icon(Icons.navigate_next_rounded,
                                    color:
                                        ColorController().getColor().colorText),
                                onTap: () {
                                  setState(() {
                                    listSetOfQuiz = e.listquiz ?? [];

                                    selectTable = 2;
                                  });
                                },
                              )
                              // : SizedBox(),
                            ],
                          ))
                        ]))
                    .toList(),
          ),
        )
      ],
    );
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
            Text(
              "Job",
              style: textStyleHeader(),
            ),
            Icon(
              Icons.add,
              color: ColorController().getColor().colorText,
              size: 32,
            )
          ],
        ),
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            dataTextStyle: textStyleTableContent(),
            headingTextStyle: textStyleTableHeader(),
            columns: const <DataColumn>[
              DataColumn(
                label: Expanded(
                  child: Text('Job name'),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Time created'),
                ),
              ),
              DataColumn(
                label: Expanded(
                  child: Text('Number of categories'),
                ),
              ),
              DataColumn(
                  label: Expanded(
                child: Text('Option'),
              )),
            ],
            rows: listJob.length == 0
                ? [RowEmpty()]
                : listJob
                    .map((e) => DataRow(cells: [
                          DataCell(Text(e.name ?? "")),
                          DataCell(Text(e.time_created.toString())),
                          DataCell(Text(e.number_categories.toString())),
                          DataCell(Row(
                            children: [
                              Spacer(),
                              Icon(Icons.edit_outlined,
                                  color:
                                      ColorController().getColor().colorText),
                              // (e.number_categories ?? 0) > 0 ?
                              InkWell(
                                child: Icon(Icons.navigate_next_rounded,
                                    color:
                                        ColorController().getColor().colorText),
                                onTap: () {
                                  setState(() {
                                    listCategories = e.categories ?? [];
                                    selectTable = 1;
                                  });
                                },
                              )
                              // : SizedBox(),
                            ],
                          ))
                        ]))
                    .toList(),
          ),
        )
      ],
    );
  }

  DataRow RowEmpty() {
    return DataRow(cells: [
      DataCell(Text("Empty")),
      DataCell(Text("")),
      DataCell(Text("")),
      DataCell(Text("")),
    ]);
  }

  TextStyle textStyleTableHeader() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope-ExtraBold",
      fontSize: 20,
      fontWeight: FontWeight.w100);
  TextStyle textStyleTableContent() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope",
      fontSize: 16,
      fontWeight: FontWeight.w100);
  TextStyle textStyleHeader() => TextStyle(
      color: ColorController().getColor().colorText,
      fontFamily: "Manrope-ExtraBold",
      decoration: TextDecoration.none,
      fontSize: 24,
      fontWeight: FontWeight.w100);
}

class TableController {
  static List<Job> listjob = [];
  void LoadData() {
    listjob = OverviewQuiz.listJob;
  }
}

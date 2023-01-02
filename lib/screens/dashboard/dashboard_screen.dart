import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/dashboard/pieChart.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../model/data_article.dart';
import '../../model/data_company.dart';
import '../../model/data_experience.dart';
import '../../model/data_question.dart';
import '../../services/database_service.dart';
import '../../style/style.dart';
import '../article/data_article.dart';
import '../experience/DataExperience.dart';
import '../question/data_question.dart';
import 'PostFigures.dart';
import 'barChart.dart';
import 'dataShared.dart';
import 'header.dart';
import 'infoCard.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({Key? key}) : super(key: key);

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  late Future<List<ArticlePost>?> articlepost;
  late List<ArticlePost>? articles;

  late Future<List<Question>?> questionpost;
  late List<Question>? questions;

  late Future<List<ExperiencePost>?> experiencepost;
  late List<ExperiencePost>? experience;

  late Future<List<Company>?> companylist;
  late List<Company>? companies;

  late Future<List<ArticlePost>?> _dataFuture;
  @override
  void initState() {
    FirebaseFirestore _db = FirebaseFirestore.instance;

    articlepost =
        _db.collection('articles').get().then(_articlesFromQuerySnapshot);
    questionpost =
        _db.collection('questions').get().then(_questionsListFromQuerySnapshot);
    experiencepost =
        _db.collection('experience').get().then(_experienceFromQuerySnapshot);
    companylist =
        _db.collection('companies').get().then(_companiesFromQuerySnapshot);
    _dataFuture =
        _db.collection('articles').get().then(_articlesFromQuerySnapshot);
    super.initState();
  }

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

  List<ExperiencePost>? _experienceFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<ExperiencePost>? res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
    res.sort((a,b){
      int x=a.liked_users==null? 0: (a.liked_users!.length);
      int y=b.liked_users==null? 0: (b.liked_users!.length);;
      return y.compareTo(x);
    });
    DataExperience.dataExperienceDashboard = res ?? [];
    DataExperience.getTop5();
    return res;
  }


  List<Question>? _questionsListFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    List<Question>? res;
    res = querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Question.fromJson(documentSnapshot.data());
      }
      return Question.test();
    }).toList();
    res.sort((a,b){
      int x=a.upvote_users==null||a.downvote_users==null? 0: (a.upvote_users!.length-a.downvote_users!.length);
      int y=b.upvote_users==null||b.downvote_users==null? 0: (b.upvote_users!.length-b.downvote_users!.length);
      return y.compareTo(x);
    });
    DataQuestion.dataQuestionDashboard = res ?? [];
    DataQuestion.getTop5();
    return res;
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
    result.sort((a,b){
      int x=a.liked_users==null?0:a.liked_users!.length;
      int y=b.liked_users==null?0:b.liked_users!.length;
      return y.compareTo(x);
    });
    DataArticle.dataArticleDashboard = result ?? [];
    DataArticle.getTop5();
    return result;
  }

  Widget articlePart() {
    return FutureBuilder(
      future: articlepost,
      builder:
          (BuildContext context, AsyncSnapshot<List<ArticlePost>?> snapshot) {
        articles = snapshot.data;
        if (snapshot.data != null) {
          SharedData.numArticle = articles!.length;
        }

        return InfoCard(
            icon: 'assets/article.svg',
            label: 'Number of \nArticle',
            amount: articles == null ? '\0' : '\ ${SharedData.numArticle}');
      },
    );
  }

  Widget questionPart() {
    return FutureBuilder(
      future: questionpost,
      builder: (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
        questions = snapshot.data;
        if (snapshot.data != null) {
          SharedData.numQuestion = questions == null ? 1 : questions!.length;
        }

        return InfoCard(
            icon: 'assets/question.svg',
            label: 'Number of \nQuestion',
            amount: questions == null ? '\0' : '\ ${SharedData.numQuestion}');
      },
    );
  }

  Widget experiencePart() {
    return FutureBuilder(
      future: experiencepost,
      builder: (BuildContext context,
          AsyncSnapshot<List<ExperiencePost>?> snapshot) {
        experience = snapshot.data;
        if (snapshot.data != null) {
          SharedData.numExperience =
              experience == null ? 1 : experience!.length;
        }
        return InfoCard(
            icon: 'assets/experience.svg',
            label: 'Number of \nExperience post',
            amount:
                experience == null ? '\0' : '\ ${SharedData.numExperience}');
      },
    );
  }

  Widget companyPart() {
    return FutureBuilder(
      future: companylist,
      builder: (BuildContext context, AsyncSnapshot<List<Company>?> snapshot) {
        companies = snapshot.data;
        if (snapshot.data != null) {
          SharedData.numCompany = companies == null ? 0 : companies!.length;
        }
        return InfoCard(
            icon: 'assets/company.svg',
            label: 'Number of \nCompany',
            amount: companies == null ? '\0' : '\ ${SharedData.numCompany}');
      },
    );
  }

  Widget quizPart() {
    return InfoCard(
        icon: 'assets/quiz.svg',
        label: 'Number of \nQuiz',
        amount: '\ ${SharedData.numQuiz}');
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

            ],
            rows: DataArticle.dataArticleDashboard == null
                ? [RowEmpty()]
                : DataArticle.dataArticleDashboard
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
            ]))
                .toList(),
          ),
        );
      },
    );
  }

  Widget DataTableQuestion() {
    return FutureBuilder(
      future: questionpost,
      builder: (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
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
                    'Question Title',
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
            ],
            rows: DataQuestion.dataQuestionDashboard == null
                ? [RowEmpty()]
                : DataQuestion.dataQuestionDashboard
                .map((question) => DataRow(cells: [
              DataCell(Text(question.id!,
                  style: textStyleTableContent())),
              DataCell(Text(question.title!,
                  style: textStyleTableContent())),
              DataCell(Text(question.created_at.toString(),
                  style: textStyleTableContent())),
            ]))
                .toList(),
          ),
        );
      },
    );
  }

  Widget DataTableExperience() {
    return FutureBuilder(
      future: experiencepost,
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
            ],
            rows: DataExperience.dataExperienceDashboard == null
                ? [RowEmpty()]
                : DataExperience.dataExperienceDashboard
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
        child: Container(
          color: ColorController().getColor().colorBody,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                  flex: 10,
                  child: SafeArea(
                    child: SingleChildScrollView(
                      padding:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Header(),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          SizedBox(
                            width: SizeConfig.screenWidth,
                            child: Wrap(
                              spacing: 20,
                              runSpacing: 20,
                              alignment: WrapAlignment.spaceBetween,
                              children: [
                                articlePart(),
                                questionPart(),
                                experiencePart(),
                                companyPart(),
                                quizPart(),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                      text: 'Top 5 article posts have most interactive',
                                      color: ColorController()
                                          .getColor()
                                          .colorText,
                                      size: 30,
                                      fontWeight: FontWeight.w800),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          DataTableArticle(),

                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                      text: 'Top 5 questions have most interactive',
                                      color: ColorController()
                                          .getColor()
                                          .colorText,
                                      size: 30,
                                      fontWeight: FontWeight.w800),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          DataTableQuestion(),

                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 4,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  PrimaryText(
                                      text: 'Top 5 experience posts have most interactive',
                                      color: ColorController()
                                          .getColor()
                                          .colorText,
                                      size: 30,
                                      fontWeight: FontWeight.w800),
                                ],
                              )
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 3,
                          ),
                          DataTableExperience(),
                        ],
                      ),
                    ),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

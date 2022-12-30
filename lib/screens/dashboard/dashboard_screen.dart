import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../config/size_config.dart';
import '../../model/data_article.dart';
import '../../model/data_company.dart';
import '../../model/data_experience.dart';
import '../../model/data_question.dart';
import '../../style/style.dart';
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

  Widget accountPart() {
    return InfoCard(
        icon: 'assets/account.svg',
        label: 'Number of \nAccount',
        amount: '\ ${SharedData.numAccount}');
  }

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
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
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
    return res;
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
                                accountPart(),
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
                                      text: 'Statistics',
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
                          Container(
                            height: 180,
                            child: BarChartCopmponent(
                              account: SharedData.numAccount,
                              article: SharedData.numArticle,
                              question: SharedData.numQuestion,
                              experience: SharedData.numExperience,
                              company: SharedData.numCompany,
                              quiz: SharedData.numQuiz,
                            ),
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 5,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              PrimaryText(
                                  text: 'All Post Figures',
                                  color: ColorController().getColor().colorText,
                                  size: 30,
                                  fontWeight: FontWeight.w800),
                              PrimaryText(
                                text: 'Manage All Post Figures',
                                size: 16,
                                fontWeight: FontWeight.w400,
                                color: ColorController()
                                    .getColor()
                                    .colorText
                                    .withOpacity(0.7),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: SizeConfig.blockSizeVertical * 2.5,
                          ),
                          PostFigures(
                              article: SharedData.numArticle,
                              question: SharedData.numQuestion,
                              experience: SharedData.numExperience),
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

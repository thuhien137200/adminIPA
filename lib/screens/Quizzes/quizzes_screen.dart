import 'package:admin_ipa/controller/color_theme_controller.dart';
import 'package:admin_ipa/screens/quizzes/component/custom_sidebar_quiz.dart';
import 'package:admin_ipa/screens/quizzes/component/overview.dart';
import 'package:admin_ipa/screens/quizzes/controller/quizzes_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../model/data_quizzes.dart';
import '../../services/quizzes_services.dart';
import 'component/custom_information.dart';

class QuizScreen extends StatelessWidget {
  QuizScreen({Key? key, required this.size}) : super(key: key);
  final Size size;

  Future<List<Job>> loadDataQuiz() async {
    // OverviewQuiz().reset();
    int numberJob = 0,
        numberCategories = 0,
        numberSetOfQuiz = 0,
        numberQuestion = 0;
    FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference collectionJob = _db.collection('quizzes');
    List<Job>? result = [];
    result = await QuizzesServices().getJobList(collectionJob);
    numberJob = (result ?? []).length;
    for (int i = 0; i < result!.length; i++) {
      CollectionReference collectionCategories =
          collectionJob.doc(result[i].id).collection('categories');
      List<Categories>? listCategories = [];
      listCategories =
          await QuizzesServices().getCategoriesList(collectionCategories);
      numberCategories += listCategories.length;
      result[i].setCategories(listCategories);
      for (int j = 0; j < result[i].getCategories().length; j++) {
        CollectionReference collectionSetOfQuiz = collectionCategories
            .doc(result[i].getCategories()[j].id)
            .collection('setofquestion');
        List<SetOfQuiz>? listSetOfQuizz = [];
        listSetOfQuizz =
            await QuizzesServices().getSetOfQuizList(collectionSetOfQuiz);
        numberSetOfQuiz += listSetOfQuizz.length;
        result[i].getCategories()[j].setQuiz(listSetOfQuizz);
        for (int k = 0;
            k < result[i].getCategories()[j].getSetOfQuiz().length;
            k++) {
          CollectionReference collectionQuestion = collectionSetOfQuiz
              .doc(result[i].getCategories()[j].getSetOfQuiz()[k].id)
              .collection('question');
          AggregateQuerySnapshot query = await collectionQuestion.count().get();
          numberQuestion += query.count;
          result[i].getCategories()[j].getSetOfQuiz()[k].number_question =
              query.count;
        }
      }
    }
    OverviewQuiz.listJob = result ?? [];
    OverviewQuiz.numberJob = numberJob;
    OverviewQuiz.numberCategories = numberCategories;
    OverviewQuiz.numberQuizzes = numberSetOfQuiz;
    OverviewQuiz.numberQuestion = numberQuestion;
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: loadDataQuiz(),
        builder: (context, snapshot) {
          return Scaffold(
              key: QuizzesController.key,
              endDrawer: CustomSideBarQuiz(),
              body: buildItem());
        });
  }

  Container buildItem() {
    return Container(
      height: size.height,
      width: size.width,
      color: ColorController().getColor().colorBody,
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text(
            "Overview",
            style: TextStyle(
                color: ColorController().getColor().colorText,
                fontFamily: "Manrope-ExtraBold",
                decoration: TextDecoration.none,
                fontSize: 24,
                fontWeight: FontWeight.w100),
          ),
          Overview(width: size.width - 40),
          Container(
            width: size.width,
            padding: EdgeInsets.all(10),
            child: CustomTable(),
          ),
        ]),
      ),
    );
  }
}

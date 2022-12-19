import 'package:admin_ipa/screens/login/component/style.dart';
import 'package:admin_ipa/screens/quizzes/component/style_table.dart';
import 'package:admin_ipa/services/quizzes_services.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../controller/color_theme_controller.dart';
import '../../../model/data_quizzes.dart';
import '../controller/quizzes_controller.dart';

class DataSideBarQuiz {
  static int status = 0;
  static String name = "";
  static String description = "";
  static List<QuestionQuiz> listQuestion = [];
  static late String idJob, idCategories, idQuiz, quizName;

  void reset() {
    name = "";
    description = "";
    listQuestion = [];
  }

  Future<int> loadData() async {
    List<QuestionQuiz> listQuestionOfQuiz = [];

    FirebaseFirestore _db = FirebaseFirestore.instance;
    DocumentReference documentReferenceSetOfQuiz = _db
        .collection('quizzes')
        .doc(idJob)
        .collection('categories')
        .doc(idCategories)
        .collection('setofquestion')
        .doc(idQuiz);
    CollectionReference collectionQuestion =
        documentReferenceSetOfQuiz.collection('question');
    listQuestionOfQuiz =
        await QuizzesServices().getQuestionOfQuiz(collectionQuestion);
    for (int i = 0; i < listQuestionOfQuiz.length; i++) {
      CollectionReference collectionAnswers = collectionQuestion
          .doc(listQuestionOfQuiz[i].id)
          .collection('answers');
      List<Answer> listAnswers = [];
      listAnswers = await QuizzesServices().getAnswers(collectionAnswers);
      listQuestionOfQuiz[i].setAnswers(listAnswers);
    }
    CollectionReference collectionDescription =
        documentReferenceSetOfQuiz.collection('Discription');
    List<String> listDescription =
        await QuizzesServices().getDescriptionOfQuiz(collectionDescription);
    name = quizName;
    description = listDescription[0];
    listQuestion = listQuestionOfQuiz;
    return 1;
  }

  // Widget setData(String idJob, String idCategories, String idQuiz) {
  //   FutureBuilder(
  //     future: loadData(idJob, idCategories, idQuiz),
  //     builder: (context, snapshot) {
  //       if (snapshot.connectionState == ConnectionState.waiting)
  //         return Style().messages("Load data done");

  //       if (snapshot.hasError) return Style().messages(snapshot.error);

  //       return Center(child: CircularProgressIndicator());
  //     },
  //   );
  // }
}

class CustomSideBarQuiz extends StatelessWidget {
  const CustomSideBarQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController discription = TextEditingController();
    print(DataSideBarQuiz.status);
    if (DataSideBarQuiz.status == 0) {
      Drawer d = Drawer(
          width: 500,
          backgroundColor: ColorController().getColor().colorBody,
          child: buildItem(name, discription));
      return d;
    }
    name.text = DataSideBarQuiz.name;
    discription.text = DataSideBarQuiz.description;
    Drawer d = Drawer(
      width: 500,
      backgroundColor: ColorController().getColor().colorBody,
      child: FutureBuilder(
          future: DataSideBarQuiz().loadData(),
          builder: (context, AsyncSnapshot<int> snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
            }
            if (snapshot.hasData) {
              return buildItem(name, discription);
            }
            return Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
    return d;
  }

  Container buildItem(
      TextEditingController name, TextEditingController discription) {
    return Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                "Quiz name: ",
                style: StyleTable().textStyleHeader(),
              ),
              Container(
                height: 45,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: StyleTable().decorationBox(),
                child:
                    StyleTable().customInputText(name, "Enter the name quiz"),
              ),
              Text(
                "Discription: ",
                style: StyleTable().textStyleHeader(),
              ),
              Container(
                height: 150,
                margin: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
                padding: EdgeInsets.symmetric(horizontal: 10),
                decoration: StyleTable().decorationBox(),
                child: StyleTable()
                    .customInputText(discription, "Enter the discription"),
              ),
              CustomBoxQuestion(),
              Align(
                  child: GestureDetector(
                onTap: () {
                  if (name.text.isEmpty) {
                    StyleTable().messages("Name quiz cannot empty");
                    return;
                  }
                  if (discription.text.isEmpty) {
                    StyleTable().messages("Discription quiz cannot empty");
                    return;
                  }
                  if (DataSideBarQuiz.listQuestion.length == 0) {
                    StyleTable().messages("Question quiz cannot empty");
                    return;
                  }
                  QuizzesServices().addQuizz(name.text, discription.text,
                      DataSideBarQuiz.listQuestion, "");
                  QuizzesController.key.currentState!.closeEndDrawer();
                },
                child: Container(
                  height: 50,
                  width: 150,
                  decoration: StyleTable().decorationBoxAdd(),
                  child: Align(
                    child: Text("Submit",
                        style: StyleTable().textStyleTableHeader()),
                  ),
                ),
              ))
            ],
          ),
        ));
  }
}

class CustomBoxQuestion extends StatefulWidget {
  const CustomBoxQuestion({Key? key}) : super(key: key);

  @override
  State<CustomBoxQuestion> createState() => _CustomBoxQuestionState();
}

class _CustomBoxQuestionState extends State<CustomBoxQuestion> {
  @override
  Widget build(BuildContext context) {
    double _height = MediaQuery.of(context).size.height;
    double _width = MediaQuery.of(context).size.width;
    return Container(
      padding: EdgeInsets.all(10),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Questions of quiz: ",
                style: StyleTable().textStyleHeader(),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    DataSideBarQuiz.listQuestion.add(QuestionQuiz(
                        content: "", listAnswer: [], correctAnswer: -1));
                  });
                },
                child: Container(
                    height: 50,
                    width: 100,
                    decoration: StyleTable().decorationBoxAdd(),
                    child: Icon(
                      Icons.add_rounded,
                      color: ColorController().getColor().colorText,
                    )),
              ),
            ],
          ),
          listQuestion(_height),
        ],
      ),
    );
  }

  Widget listQuestion(double height) {
    return Container(
      height: height,
      child: MasonryGridView.count(
        itemCount: DataSideBarQuiz.listQuestion.length,
        crossAxisCount: 1,
        itemBuilder: (context, indexQuestion) {
          TextEditingController content = TextEditingController();
          content.text =
              DataSideBarQuiz.listQuestion[indexQuestion].content ?? "";

          return Container(
            margin: EdgeInsets.all(10),
            decoration: StyleTable().decorationBox(),
            padding: EdgeInsets.all(10),
            child: Column(
              children: [
                customInputQuestionContent(content, indexQuestion),
                Container(
                  height: 200,
                  child: MasonryGridView.count(
                      itemCount: DataSideBarQuiz
                          .listQuestion[indexQuestion].listAnswer.length,
                      crossAxisCount: 1,
                      itemBuilder: (context, indexAnswer) {
                        TextEditingController contentAnswers =
                            TextEditingController();

                        return Container(
                            margin: EdgeInsets.symmetric(
                                horizontal: 10, vertical: 5),
                            padding: EdgeInsets.all(10),
                            decoration: StyleTable().decorationBox(),
                            child: Row(
                              children: [
                                Container(
                                  width: 25,
                                  height: 25,
                                  child: DataSideBarQuiz
                                              .listQuestion[indexQuestion]
                                              .correctAnswer ==
                                          indexAnswer
                                      ? Icon(
                                          Icons.check_circle,
                                          color: Colors.green,
                                        )
                                      : GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              DataSideBarQuiz
                                                  .listQuestion[indexQuestion]
                                                  .correctAnswer = indexAnswer;
                                            });
                                          },
                                          child: Icon(
                                            Icons.panorama_fish_eye,
                                            color: ColorController()
                                                .getColor()
                                                .colorText,
                                          ),
                                        ),
                                ),
                                Container(
                                  width: 300,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  child: customInputAnswersContent(
                                      contentAnswers,
                                      indexQuestion,
                                      indexAnswer),
                                )
                              ],
                            ));
                      }),
                ),
                Align(
                  alignment: Alignment.bottomRight,
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        print("object");
                        DataSideBarQuiz.listQuestion[indexQuestion].listAnswer
                            .add(Answer(content: "", correct: false));
                      });
                    },
                    child: Container(
                        height: 50,
                        width: 50,
                        decoration: StyleTable().decorationBoxAdd(),
                        child: Icon(
                          Icons.add_rounded,
                          color: ColorController().getColor().colorText,
                        )),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  TextField customInputAnswersContent(
      TextEditingController content, int indexQuestion, int indexAnswer) {
    content.text = DataSideBarQuiz
            .listQuestion[indexQuestion].listAnswer[indexAnswer].content ??
        "";
    return TextField(
      controller: content,
      maxLines: null,
      style: TextStyle(color: ColorController().getColor().colorText),
      decoration: InputDecoration(
          hintText: "Answers content",
          hintStyle: TextStyle(
              color: ColorController().getColor().colorText.withOpacity(0.5)),
          border: InputBorder.none),
      onChanged: (String value) {
        DataSideBarQuiz.listQuestion[indexQuestion].listAnswer[indexAnswer]
            .content = value;
      },
    );
  }

  TextField customInputQuestionContent(
      TextEditingController content, int index) {
    return TextField(
      controller: content,
      maxLines: null,
      style: TextStyle(color: ColorController().getColor().colorText),
      decoration: InputDecoration(
          hintText: "Question content",
          hintStyle: TextStyle(
              color: ColorController().getColor().colorText.withOpacity(0.5)),
          border: InputBorder.none),
      onChanged: (String value) {
        DataSideBarQuiz.listQuestion[index].content = value;
      },
    );
  }
}

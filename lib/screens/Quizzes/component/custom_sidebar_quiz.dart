import 'package:admin_ipa/screens/quizzes/component/style_table.dart';
import 'package:admin_ipa/services/quizzes_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import '../../../controller/color_theme_controller.dart';
import '../../../model/data_quizzes.dart';

class DataSideBarQuiz {
  static String name = "";
  static String description = "";
  static List<QuestionQuiz> listQuestion = [];
}

class CustomSideBarQuiz extends StatelessWidget {
  const CustomSideBarQuiz({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    TextEditingController name = TextEditingController();
    TextEditingController discription = TextEditingController();

    Drawer d = Drawer(
      width: 500,
      backgroundColor: ColorController().getColor().colorBody,
      child: Container(
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
          )),
    );
    return d;
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

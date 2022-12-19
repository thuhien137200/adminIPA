import 'package:admin_ipa/screens/quizzes/component/custom_sidebar_quiz.dart';
import 'package:admin_ipa/screens/quizzes/controller/quizzes_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import '../model/data_quizzes.dart';

class QuizzesServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Job>?> getJobList(CollectionReference collection) async {
    // CollectionReference collection = _db.collection('quizzes');
    List<Job>? result = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;

          Job a = Job.fromJson(data, doc.id);

          return a;
        }
        return Job();
      }).toList();
    });
    return result;
  }

  Future<List<Categories>> getCategoriesList(
      CollectionReference collection) async {
    // CollectionReference collection =
    //     _db.collection('quizzes').doc(jobId).collection('categories');
    List<Categories> result = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Categories a = Categories.fromJson(data, doc.id);

          return a;
        }
        return Categories();
      }).toList();
    });
    return result.isEmpty ? [] : result;
  }

  Future<List<SetOfQuiz>> getSetOfQuizList(
      CollectionReference collection) async {
    List<SetOfQuiz> result = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          SetOfQuiz a = SetOfQuiz.fromJson(data, doc.id);

          return a;
        }
        return SetOfQuiz();
      }).toList();
    });
    return result.isEmpty ? [] : result;
  }

  Future<List<QuestionQuiz>> getQuestionOfQuiz(
      CollectionReference collection) async {
    List<QuestionQuiz>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          QuestionQuiz a = QuestionQuiz.fromJson(data, doc.id);
          return a;
        }
        return QuestionQuiz(listAnswer: []);
      }).toList();
    });

    return result ?? [];
  }

  Future<List<String>> getDescriptionOfQuiz(
      CollectionReference collection) async {
    List<String>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          String a = data!['content'];
          return a;
        }
        return "";
      }).toList();
    });

    return result ?? [];
  }

  Future<List<Answer>> getAnswers(CollectionReference collection) async {
    List<Answer>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Answer a = Answer.fromJson(data, doc.id);
          return a;
        }
        return Answer();
      }).toList();
    });

    return result ?? [];
  }

  Future<int> totalNumberQuiz() async {
    int numberSetOfQuiz = 0;
    FirebaseFirestore _db = FirebaseFirestore.instance;
    CollectionReference collectionJob = _db.collection('quizzes');
    List<Job>? result = [];
    result = await QuizzesServices().getJobList(collectionJob);
    for (int i = 0; i < result!.length; i++) {
      CollectionReference collectionCategories =
          collectionJob.doc(result[i].id).collection('categories');
      List<Categories>? listCategories = [];
      listCategories =
          await QuizzesServices().getCategoriesList(collectionCategories);
      result[i].setCategories(listCategories);
      for (int j = 0; j < result[i].getCategories().length; j++) {
        CollectionReference collectionSetOfQuiz = collectionCategories
            .doc(result[i].getCategories()[j].id)
            .collection('setofquestion');
        AggregateQuerySnapshot query = await collectionSetOfQuiz.count().get();
        numberSetOfQuiz += query.count;
      }
    }
    return numberSetOfQuiz;
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

  Future<void> addData(CollectionReference collectionReference,
      Map<String, dynamic> data, String mess) async {
    collectionReference
        .add(data)
        .then((DocumentReference doc) => messages(mess));
  }

  Future<void> deleteData(
      String? idJob, String? idCategories, String? idQuiz, String mess) async {
    DocumentReference documentReference = _db.collection('quizzes').doc(idJob);
    if (idCategories != null) {
      documentReference =
          documentReference.collection('categories').doc(idCategories);
    }
    if (idQuiz != null) {
      documentReference =
          documentReference.collection('setofquestion').doc(idQuiz);
    }
    await documentReference.delete();
    messages(mess);
  }

  Future<void> updateData(DocumentReference documentReference,
      Map<String, dynamic> data, String mess) async {
    documentReference.update(data).then((value) => messages(mess));
  }

  Future<void> addQuizz(String name, String discription,
      List<QuestionQuiz> list, String mess) async {
    CollectionReference collectionReference =
        QuizzesController().getDocCategories().collection('setofquestion');
    Map<String, dynamic> dataQuiz = {
      'name': name,
      'time_created': Timestamp.now()
    };
    String idQuiz = "";
    await collectionReference.add(dataQuiz).then((DocumentReference doc) {
      idQuiz = doc.id;
      debugPrint("Add name ${doc.id}");
    });

    await collectionReference
        .doc(idQuiz)
        .collection('description')
        .add({'content': discription}).then((DocumentReference doc) {
      debugPrint("Add description");
    });

    CollectionReference collectionQuestion =
        collectionReference.doc(idQuiz).collection('question');

    for (int i = 0; i < list.length; i++) {
      if (list[i].content == "") continue;
      String idQuestion = "";
      await collectionQuestion
          .add({'content': list[i].content}).then((DocumentReference doc) {
        idQuestion = doc.id;
        debugPrint("Add question content $i");
      });
      CollectionReference collectionAnswer =
          collectionQuestion.doc(idQuestion).collection('answers');
      for (int j = 0; j < list[i].listAnswer.length; j++) {
        if (list[i].listAnswer[j].content == "") continue;
        Map<String, dynamic> dataAnswers = {
          'content': list[i].listAnswer[j].content,
          'correct': list[i].correctAnswer == j ? true : false
        };
        await collectionAnswer.add(dataAnswers).then((DocumentReference doc) {
          debugPrint("Add question content $i $j");
        });
      }
    }
    messages("Add quizzes successfully");
    DataSideBarQuiz().reset();
  }
}

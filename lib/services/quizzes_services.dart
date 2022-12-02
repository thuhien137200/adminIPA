import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

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
    // CollectionReference collection =
    //     _db.collection('quizzes').doc(jobId).collection('categories');
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
}

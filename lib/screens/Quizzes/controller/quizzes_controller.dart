import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../../../model/data_quizzes.dart';

class QuizzesController {
  static String jobId = "";
  static String categoriesId = "";
  static int selected = 0;

  static GlobalKey<ScaffoldState> key = GlobalKey();

  DocumentReference getDocJob() {
    FirebaseFirestore _db = FirebaseFirestore.instance;
    return _db.collection("quizzes").doc(jobId);
  }

  DocumentReference getDocCategories() {
    return getDocJob().collection("categories").doc(categoriesId);
  }
}

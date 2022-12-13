import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../model/data_question.dart';

mixin QAService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Stream<List<Question>?> get allQuestions {
    return _db
        .collection('questions')
        .snapshots()
        .map(_questionsListFromQuerySnapshot);
  }

  Future<List<Question>?> get allQuestionsOnce {
    return _db
        .collection('questions')
        .get()
        .then(_questionsListFromQuerySnapshot);
  }

  Stream<int> getVoteNum(String questionId) {
    return _db
        .collection('questions')
        .doc(questionId)
        .snapshots()
        .map((snapshot) {
      final data = snapshot.data();
      List<String>? upVoteList = data?['upvote_users'] is Iterable
          ? List.from(data?['upvote_users'])
          : null;
      List<String>? downVoteList = data?['downvote_users'] is Iterable
          ? List.from(data?['downvote_users'])
          : null;
      return (upVoteList?.length ?? 0) - (downVoteList?.length ?? 0);
    });
  }

  Stream<int> getNumberOfAnswers(String questionId) {
    return _db
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .snapshots()
        .map((snapshot) => snapshot.docs.length);
  }

  void deleteCommentFromQuestion(String commentId, String questionId) async {
    try{
      await _db
        .collection('questions')
        .doc(questionId)
        .collection('answers')
        .doc(commentId)
        .delete();
    }
    catch(e){
        print('Delete fails');
      return;
    }
  }

  void deleteQA(String? idQa) async {
    try {
      await _db.collection('questions').doc(idQa).delete();
    } catch (e) {
      print('Delete fails');
      return;
    }
  }
}

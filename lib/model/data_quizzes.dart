import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Job {
  String? id;
  String? name;
  DateTime? time_created;
  int? number_categories;
  List<Categories>? categories;

  Job({
    this.id,
    this.name,
    this.time_created,
    this.number_categories,
    this.categories,
  });

  factory Job.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String name = data?['jobs'];
    final DateTime time_created = (data?['time_created'] as Timestamp).toDate();
    return Job(
        id: id,
        name: name,
        time_created: time_created,
        number_categories: 0,
        categories: []);
  }
  void setCategories(List<Categories> categories) {
    number_categories = categories.length;
    this.categories = categories;
  }

  List<Categories> getCategories() => categories ?? [];
}

class Categories {
  String? id;
  String? name;
  DateTime? time_created;
  int? number_quiz;
  List<SetOfQuiz>? listquiz;

  Categories({
    this.id,
    this.name,
    this.time_created,
    this.number_quiz,
    this.listquiz,
  });

  factory Categories.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String name = data?['name'];
    final DateTime time_created = (data?['time_created'] as Timestamp).toDate();
    return Categories(
        id: id,
        name: name,
        time_created: time_created,
        number_quiz: 0,
        listquiz: []);
  }
  void setQuiz(List<SetOfQuiz> quiz) {
    number_quiz = quiz.length;
    this.listquiz = quiz;
  }

  List<SetOfQuiz> getSetOfQuiz() => listquiz ?? [];
}

class SetOfQuiz {
  String? id;
  String? name;
  DateTime? time_created;
  int? number_question;
  // List<Quiz>? listquiz;

  SetOfQuiz({
    this.id,
    this.name,
    this.time_created,
    this.number_question,
    // this.listquiz,
  });

  factory SetOfQuiz.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String name = data?['name'];
    final DateTime time_created = (data?['time_created'] as Timestamp).toDate();
    return SetOfQuiz(
        id: id, name: name, time_created: time_created, number_question: 0);
  }
}

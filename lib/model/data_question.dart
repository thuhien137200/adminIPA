import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Question {
  String? id;
  String? title;
  String? content;
  DateTime? created_at;
  String? author_id;
  String? company_id;
  List<String>? categories;
  List<String>? upvote_users;
  List<String>? downvote_users;

  Question(
      this.id,
      this.title,
      this.content,
      this.created_at,
      this.author_id,
      this.company_id,
      this.categories,
      this.upvote_users,
      this.downvote_users,
      );

  Question.only({
    this.id,
    this.title,
    this.content,
    this.created_at,
    this.author_id,
    this.company_id,
    this.categories,
    this.upvote_users,
    this.downvote_users
  });

  factory Question.test() {
    var id = 'id_test';

    var content = 'sample content';
    var created_at = DateTime.now();
    var title = 'This is a test questions';
    var company_id = 'RvxU3Ir2KkQp1hjKzRcg';
    return Question.only(
      id: id,
      content: content,
      created_at: created_at,
      company_id: company_id,
      title: title,
    );
  }
  void setId(String? id) => this.id = id;
  void setAuthorId(String? id) => author_id = id;

  factory Question.fromJson(Map<String, dynamic>? json) {
    final String? id = json?['id'];
    final String? title = json?['title'];
    final String? content = json?['content'];
    final String? date_string_created = json?['created_at'];
    // DateFormat formatter = DateFormat('dd/MM/yyyy');
    // final DateTime created_at =
    //     formatter.parse(date_string_created ?? '1/1/2001');
    final DateTime created_at = DateTime.parse(
        date_string_created ?? DateTime.utc(2001, 1, 1).toString());
    final String? author_id = json?['author_id'] as String?;
    final String? company_id = json?['company_id'] as String?;
    final List<String>? categories =
    json?['categories'] is Iterable ? List.from(json?['categories']) : null;

    final List<String>? upvote_users = json?['upvote_users'] is Iterable
        ? List.from(json?['upvote_users'])
        : null;

    final List<String>? downvote_users = json?['downvote_users'] is Iterable
        ? List.from(json?['downvote_users'])
        : null;

    // final List<Comment>? answers =
    //     json?['answers'] is Iterable ? List.from(json?['answers']) : null;

    return Question(id, title, content, created_at, author_id, company_id,
        categories, upvote_users, downvote_users);
  }

  factory Question.fromQuerySnapshot(
      QueryDocumentSnapshot<Map<String, dynamic>> queryDocumentSnapshot) {
    return Question.fromJson(queryDocumentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (title != null) 'title': title,
    if (content != null) 'content': content,
    if (created_at != null) 'created_at': created_at.toString(),
    if (author_id != null) 'author_id': author_id,
    if (company_id != null) 'company_id': company_id,
    if (categories != null) 'categories': categories,
    if (upvote_users != null) 'upvote_users': upvote_users,
    if (downvote_users != null) 'downvote_users': downvote_users,
    // if (answers != null) 'answers': answers,
  };

  void addUpvoteUser(String userId) {
    if (upvote_users == null) {
      upvote_users = <String>[];
    } else {
      upvote_users!.add(userId);
    }
  }

  void addDownvoteUser(String userId) {
    if (downvote_users == null) {
      downvote_users = <String>[];
    } else {
      downvote_users!.add(userId);
    }
  }





  static List<Question> getSampleQuestions() {
    List<Question> _sampleQuestion = [];
    _sampleQuestion
      ..add(Question(
        '0',
        'Remove duplicate',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2021, 10, 11, 20, 30),
        '100',
        '1',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
      ))
      ..add(Question(
        '1',
        'Remove duplicate character in string',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2021, 10, 11, 20, 30),
        '100',
        '1',
        ['c++', 'string', 'algorithm'],
        ['0', '1', '2'],
        ['5'],
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
      ))
      ..add(Question(
        '0',
        'Cleaning up data where it repeats daily',
        'I am working with a Qualtrics survey where blocks of questions repeat themselves',
        DateTime(2022, 4, 11, 9, 30),
        '101',
        '2',
        ['C++', 'C#', 'Algorithm'],
        ['0', '1', '2'],
        ['5'],
      ));
    debugPrint('Length: ${_sampleQuestion.length.toString()}');
    return _sampleQuestion;
  }
}

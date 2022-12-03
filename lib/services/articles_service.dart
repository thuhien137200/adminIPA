import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../model/data_article.dart';

mixin ArticlePostHandle {
  FirebaseFirestore _db = FirebaseFirestore.instance;

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

  Stream<List<ArticlePost>?> get allArticles {
    return _db
        .collection('articles')
        .snapshots()
        .map(_articlesFromQuerySnapshot);
  }

  Future<List<ArticlePost>?> get allArticlesOnce {
    return _db.collection('articles').get().then(_articlesFromQuerySnapshot);
  }

  Future<List<ArticlePost>?> getArticlesList() async {
    CollectionReference collection = _db.collection('articles');
    // return a QuerySnapshot, which is a collection query
    // To access documents in a collection,
    // querySnapshot.docs() => return a List<DocumentSnapshot>
    List<ArticlePost>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      // print(querySnapshot.docs.first.data());
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          ArticlePost a = ArticlePost.fromJson(data);
          return a;
        }
        return ArticlePost.test();
      }).toList();
    });
    return result;
  }



}

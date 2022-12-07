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

  void addArticle(ArticlePost article) async {
    DocumentReference doc = _db.collection('articles').doc();
    String doc_id = doc.id;
    if (article.id == null) article.setId(doc_id);
    String? user_id = 'JOcWUTwArybiZjO9CelOhvBApCT2';
    article.setAuthorId(user_id);

    // Add article comments to firebase
    CollectionReference subcollection =
        _db.collection('articles').doc(doc_id).collection('comments');
    

    // Add article to firebase
    doc
        .set(article.toJson())
        .then((value) => print('Article added successfully'))
        .catchError((error) => print('Failed to add an article'));
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

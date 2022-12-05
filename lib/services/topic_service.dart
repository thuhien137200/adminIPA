import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/data_topic.dart';

mixin TopicService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Topic>? _topicsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Topic.fromDocumentSnapshot(documentSnapshot);
      }
      return Topic.test();
    }).toList();
  }

  Future<List<Topic>?> get allTopicOnce {
    return _db.collection('topic').get().then(_topicsFromQuerySnapshot);
  }


}

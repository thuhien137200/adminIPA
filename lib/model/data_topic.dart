import 'package:cloud_firestore/cloud_firestore.dart';

class Topic {
  String? topic_id;
  String? topic_name;

  Topic(this.topic_id, this.topic_name);

  String get idTopic{
    return topic_id?? '-1';
  }
  factory Topic.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return Topic.fromJson(documentSnapshot.data());
  }

  factory Topic.fromJson(Map<String, dynamic>? data) {
    final String? topic_id = data?['topic_id'];
    final String? topic_name = data?['topic_name'];

    return Topic.only(
      topic_id: topic_id,
      topic_name: topic_name,
    );
  }

  Topic.only({
    this.topic_id,
    this.topic_name,
  });



  factory Topic.test() {
    var topic_id = 'id_test';
    var topic_name='no_name';
    return Topic.only(
        topic_id: topic_id,
        topic_name: topic_name
    );
  }


}

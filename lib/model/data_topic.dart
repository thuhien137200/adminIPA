import 'package:cloud_firestore/cloud_firestore.dart';

class Topic {
  String? topic_id;
  String? topic_name;

  Topic(this.topic_id, this.topic_name);

  String get idTopic{
    return topic_id?? '-1';
  }

  void setTopicId(String id){
    this.topic_id=id;
  }

  void setTopicName(String name){
    this.topic_name=name;
  }

  factory Topic.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return Topic.fromJson(documentSnapshot.data());
  }

    Map<String, dynamic> toJson() => {
        if (topic_id != null) 'topic_id': topic_id,
        if (topic_name != null) 'topic_name': topic_name,
      };

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

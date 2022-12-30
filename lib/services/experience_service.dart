import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/data_experience.dart';

mixin ExperienceService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<ExperiencePost>? _experienceFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return ExperiencePost.fromDocumentSnapshot(documentSnapshot);
      }
      return ExperiencePost.test();
    }).toList();
  }

  Stream<List<ExperiencePost>?> get allExperience {
    return _db
        .collection('experience')
        .snapshots()
        .map(_experienceFromQuerySnapshot);
  }

  Future<List<ExperiencePost>?> get allExperiencePostsOnce {
    return _db
        .collection('experience')
        .get()
        .then(_experienceFromQuerySnapshot);
  }

  void acceptExperiencePost(String experiencePostId, bool isApproved) {
    _db.collection('experience').doc(experiencePostId).update({
      "isApproved": !isApproved,
    });
    print('Modify Successful');
  }

  void modifyExperiencePost(String experiencePostId, String newTopicId,
      String newTitle, String newContent) {
    _db.collection('experience').doc(experiencePostId).update({
      "topic_id": newTopicId,
      "title": newTitle,
      "content": newContent,
    });
    print('update success');
  }

  void deleteExperiencePost(String? idExperiencePost) async {
    try {
      await _db.collection("experience").doc(idExperiencePost).delete();
    } catch (e) {
      print('Delete fails');
      return;
    }
  }

  void deleteCommentFromExperiencePost(String commentId, String experiencePostId) async {
    try{
      await _db
        .collection('experience')
        .doc(experiencePostId)
        .collection('comments')
        .doc(commentId)
        .delete();
    }
    catch(e){
        print('Delete fails');
      return;
    }
  }

  void addExperiencePost(ExperiencePost experiencePost) async {
    DocumentReference doc = _db.collection('experience').doc();
    String doc_id = doc.id;
    if (experiencePost.post_id == null) experiencePost.setPostId(doc_id);

    CollectionReference subcollection =
        _db.collection('experience').doc(doc_id).collection('comments');

    doc
        .set(experiencePost.toJson())
        .then((value) => print('ExperiencePost added successfully'))
        .catchError((error) => print('Failed to add an ExperiencePost'));
  }
}

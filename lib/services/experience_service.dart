
import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/data_experience.dart';

mixin ExperienceService{
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
    return _db.collection('experience').get().then(_experienceFromQuerySnapshot);
  }



}
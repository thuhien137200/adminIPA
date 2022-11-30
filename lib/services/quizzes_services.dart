import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/data_quizzes.dart';

class QuizzesServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Job>?> getJobList() async {
    CollectionReference collection = _db.collection('quizzes');
    List<Job>? result;
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Job a = Job.fromJson(data, doc.id);
          return a;
        }
        return Job();
      }).toList();
    });
    return result;
  }
}

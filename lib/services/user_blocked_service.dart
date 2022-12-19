
import 'package:admin_ipa/model/data_user_blocked.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin UserBlockedService{

  FirebaseFirestore _db = FirebaseFirestore.instance;

   final FirebaseAuth _auth = FirebaseAuth.instance;



  List<UserBlocked>? _userBlockedsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return UserBlocked.fromDocumentSnapshot(documentSnapshot);
      }
      return UserBlocked.test();
    }).toList();
  }

  Future<List<UserBlocked>?> get allUserBlockedOnce {
    return _db.collection('userwasblocked').get().then(_userBlockedsFromQuerySnapshot);
  }

    void addUserBlocked(UserBlocked userBlocked) async {
    DocumentReference doc = _db.collection('userwasblocked').doc();
    String doc_id = doc.id;
    if (userBlocked.id_post_ban == null) userBlocked.setIdPostBan(doc_id);
    doc
        .set(userBlocked.toJson())
        .then((value) => print('Ban user added successfully'))
        .catchError((error) => print('Failed to add ban user'));
  }

  

}
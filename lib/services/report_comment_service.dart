import 'package:admin_ipa/model/data_comment_report.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

mixin CommentReportService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

   final FirebaseAuth _auth = FirebaseAuth.instance;



  List<CommentReport>? _reportCommentsFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return CommentReport.fromDocumentSnapshot(documentSnapshot);
      }
      return CommentReport.test();
    }).toList();
  }

  Future<List<CommentReport>?> get allCommentReportOnce {
    return _db.collection('reportcomment').get().then(_reportCommentsFromQuerySnapshot);
  }

    void addCommentReport(CommentReport commentReport) async {
    DocumentReference doc = _db.collection('reportcomment').doc();
    String doc_id = doc.id;
    if (commentReport.id_report_comment == null) commentReport.setIdReportComment(doc_id);
    doc
        .set(commentReport.toJson())
        .then((value) => print('Comment Report added successfully'))
        .catchError((error) => print('Failed to add Comment Report'));
  }



  void deleteReportComment(String? idReportComment) async {
    try {
      await _db.collection("reportcomment").doc(idReportComment).delete();
    } catch (e) {
      print('Delete fails');
      return;
    }

}
}
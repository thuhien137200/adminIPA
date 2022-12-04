import 'package:cloud_firestore/cloud_firestore.dart';

import '../model/data_company.dart';

mixin CompanyService {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  List<Company>? _companiesFromQuerySnapshot(
      QuerySnapshot<Map<String, dynamic>> querySnapshot) {
    return querySnapshot.docs
        .map((DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
      if (documentSnapshot.exists) {
        return Company.fromDocumentSnapshot(documentSnapshot);
      }
      return Company.test();
    }).toList();
  }

  Future<List<Company>?> get allCompanyOnce {
    return _db.collection('companies').get().then(_companiesFromQuerySnapshot);
  }


}

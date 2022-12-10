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

  void addCompany(Company company) async {
    DocumentReference doc = _db.collection('companies').doc();
    String doc_id = doc.id;
    if (company.id == null) company.setId(doc_id);
    company.setLogoUrl(company.logoUrl);
    company.setName(company.name);
    // Add article to firebase
    doc
        .set(company.toJson())
        .then((value) => print('Add company successfully'))
        .catchError((error) => print('Failed to add an company'));
  }

  Future deleteCompany(String companyId) async {
    if (companyId == null) {
      print('Failed to delete an article');
      return;
    }
    DocumentReference doc = _db.collection('companies').doc(companyId);
    return doc
        .delete()
        .then((value) => print('Delete the company successfully'))
        .catchError((error) => print('Failed to delete the company'));
  }

  void modifyCompanyInformation(
      String companyId, String newName, String newLogoUrl) {
    _db
        .collection('companies')
        .doc(companyId)
        .update({"name": newName, "logoUrl": newLogoUrl});
    print('Modify company success');
  }
}

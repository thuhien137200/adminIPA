import 'package:admin_ipa/model/data_account.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AccountServices {
  FirebaseFirestore _db = FirebaseFirestore.instance;

  Future<List<Account>?> getAccountList() async {
    CollectionReference collection = _db.collection('admin');
    List<Account>? result = [];
    await collection.get().then((QuerySnapshot querySnapshot) {
      result = querySnapshot.docs.map((doc) {
        if (doc.exists) {
          Map<String, dynamic>? data = doc.data() as Map<String, dynamic>?;
          Account a = Account.fromJson(data, doc.id);
          return a;
        }
        return Account();
      }).toList();
    });
    return result;
  }
}

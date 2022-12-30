import 'package:admin_ipa/model/data_account.dart';
import 'package:admin_ipa/screens/login/controller/login_controller.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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

  Future<Account> getAccountCurrent() async {
    DocumentReference documentReference =
        _db.collection('admin').doc(LoginController.idUser);
    Account result = new Account();
    documentReference.get();
    await documentReference.get().then((DocumentSnapshot doc) {
      if (doc.exists) {
        Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
        result = Account.fromJson(data, LoginController.idUser ?? "");
      }
    });
    return result;
  }

  void messages(String msg) {
    Fluttertoast.showToast(
        msg: msg,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.white,
        textColor: Colors.black,
        fontSize: 16.0);
  }

  Future<void> updateAccountCurrent(Map<String, dynamic> data) async {
    DocumentReference documentReference =
        _db.collection('admin').doc(LoginController.idUser);
    documentReference
        .update(data)
        .then((value) => messages("Update information successfully"));
  }
}

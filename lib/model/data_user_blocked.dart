import 'package:cloud_firestore/cloud_firestore.dart';
class UserBlocked {
  String? id_post_ban;
  String? id_user;
  DateTime? dateBan;
  bool? isUnban;

  UserBlocked(this.id_post_ban, this.id_user, this.dateBan, this.isUnban);
  UserBlocked.only({
    this.id_post_ban,
    this.id_user,
    this.dateBan,
    this.isUnban,
  });

  void setIdPostBan(String newID){
    this.id_post_ban=newID;
  }

  void setIdUser(String newUserID){
    this.id_user=newUserID;
  }

  void setDateBan(DateTime date){
    this.dateBan=date;
  }

  void setIsUnban(bool newValue){
    this.isUnban=newValue;
  }

 factory UserBlocked.test(){
  String? id_post_ban;
  String? id_user;
  DateTime? dateBan;
  bool? isUnban;
  return UserBlocked.only(
    id_post_ban: id_post_ban,
    id_user: id_user,
    dateBan: dateBan,
    isUnban: isUnban,
  );
 }

 factory UserBlocked.fromJson(Map<String, dynamic>? data) {
    final String? id_post_ban = data?['id_post_ban'];
    final String? id_user = data?['id_user'];
    final DateTime? dateBan = data?['dateBan'];
    final bool? isUnban=data?['isUnban'];

    return UserBlocked.only(
     id_post_ban: id_post_ban,
    id_user: id_user,
    dateBan: dateBan,
    isUnban: isUnban,
    );
  }

   factory UserBlocked.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return UserBlocked.fromJson(documentSnapshot.data());
  }

    Map<String, dynamic> toJson() => {
        if (id_post_ban != null) 'id_post_ban': id_post_ban,
        if (id_user != null) 'id_user': id_user,
        if (dateBan != null) 'dateBan': dateBan.toString(),
        if (isUnban !=null) 'isUnban':isUnban,
      };
}

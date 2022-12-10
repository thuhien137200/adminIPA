import 'package:cloud_firestore/cloud_firestore.dart';

class Company {
  String? id;
  String? name;
  String? logoUrl;

  Company(this.id, this.name, this.logoUrl);

  String get idCompany {
    return id ?? '-1';
  }

  void setId(String? id) => this.id = id;
  void setName(String? name) => this.name = name;
  void setLogoUrl(String? logoUrl) => this.logoUrl = logoUrl;

  factory Company.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return Company.fromJson(documentSnapshot.data());
  }

  factory Company.fromJson(Map<String, dynamic>? data) {
    final String? id = data?['id'];
    final String? name = data?['name'];
    final String? logoUrl = data?['logoUrl'];

    return Company.only(
      id: id,
      name: name,
      logoUrl: logoUrl,
    );
  }

  Company.only({
    this.id,
    this.name,
    this.logoUrl,
  });

  factory Company.test() {
    var id = 'id_test';
    var name = 'no_name';
    var logoUrl = '';
    return Company.only(
      id: id,
      name: name,
      logoUrl: logoUrl,
    );
  }
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        if (name != null) 'name': name,
        if (logoUrl != null) 'logoUrl': logoUrl,
      };
}

import 'package:cloud_firestore/cloud_firestore.dart';

class Job {
  String? id;
  String? name;
  // List<Categories>? categories;

  Job({
    this.id,
    this.name,
    // this.categories,
  });

  factory Job.fromJson(Map<String, dynamic>? data, String dataid) {
    final String id = dataid;
    final String name = data?['jobs'];
    return Job(id: id, name: name);
  }
}

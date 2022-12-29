import 'package:cloud_firestore/cloud_firestore.dart';

class CommentReport {
 String? id_report_comment;
  String? id_post;
  String? id_author_comment;
  String? id_accuser;
  String? comment_content;
  String? id_comment;
  String? report_type;
  String? screen;

  CommentReport(this.id_report_comment, this.id_post, this.id_author_comment,this.id_accuser,
      this.comment_content,this.id_comment,this.report_type, this.screen);
  
  void setScreen(String newScreen){
    this.screen=newScreen;
  }

  void setIdReportComment(String newId) {
    this.id_report_comment = newId;
  }

  void setIdAccuser(String newId){
    this.id_accuser=newId;
  }

  void setIdPost(String newId) {
    this.id_post = newId;
  }

  void setIdAuthorComment(String newId) {
    this.id_author_comment = newId;
  }

  void setCommentContent(String newContent) {
    this.comment_content = newContent;
  }

  void setReportType(String type){
    this.report_type=type;
  }

  void setIdComment(String newId){
    this.id_comment=newId;
  }

  CommentReport.only({
    this.id_report_comment,
    this.id_post,
    this.id_author_comment,
    this.id_accuser,
    this.comment_content,
    this.id_comment,
    this.report_type,
    this.screen,
  });

  factory CommentReport.test() {
    var id_report_comment = 'id_test';
    var id_post = 'id_test';
    var id_author_comment = 'no_name';
    var id_accuser='no_name';
    var comment_content = 'no_content';
    var id_comment='no_id';
    var report_type='test_type';
    var screen='no_screen';
    return CommentReport.only(
      id_report_comment: id_report_comment,
      id_post: id_post,
      id_author_comment: id_author_comment,
      id_accuser: id_accuser,
      comment_content: comment_content,
      id_comment: id_comment,
      report_type: report_type,
      screen: screen,
    );
  }

  factory CommentReport.fromJson(Map<String, dynamic>? data) {
    final String? id_report_comment = data?['id_report_comment'];
    final String? id_post = data?['id_post'];
    final String? id_author_comment = data?['id_author_comment'];
    final String? id_accuser=data?['id_accuser'];
    final String? comment_content = data?['comment_content'];
    final String? id_comment= data?['id_comment'];
    final String? report_type=data?['report_type'];
    final String? screen=data?['screen'];

    return CommentReport.only(
      id_report_comment: id_report_comment,
      id_post: id_post,
      id_author_comment: id_author_comment,
      id_accuser: id_accuser,
      comment_content: comment_content,
      id_comment: id_comment,
      report_type: report_type,
      screen: screen,
    );
  }
  factory CommentReport.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return CommentReport.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
        if (id_report_comment != null) 'id_report_comment': id_report_comment,
        if (id_post != null) 'id_post': id_post,
        if (id_author_comment != null) 'id_author_comment': id_author_comment,
        if (id_accuser !=null) 'id_accuser':id_accuser,
        if (comment_content != null) 'comment_content': comment_content,
        if (id_comment !=null) 'id_comment' : id_comment,
        if (report_type !=null) 'report_type': report_type,
        if (screen !=null) 'screen':screen,
      };
}



import 'package:cloud_firestore/cloud_firestore.dart';

class ArticlePost {
  String? id;
  String? title;
  DateTime? created_at;
  String? content;
  List<String>? categories;
  String? author_id;
  String? photoUrl;
  List<String>? liked_users;

  ArticlePost(this.id, this.title, this.created_at, this.content,
      this.categories, this.author_id, this.liked_users);

  ArticlePost.only({
    this.id,
    this.title,
    this.created_at,
    this.content,
    this.categories,
    this.author_id,
    this.photoUrl,
    this.liked_users,
  });

  factory ArticlePost.test() {
    var id = 'id_test';

    var content = 'sample content';
    var created_at = DateTime.now();
    var title = 'This is a test article';
    return ArticlePost.only(
      id: id,
      content: content,
      created_at: created_at,
      title: title,
    );
  }

  void setId(String? id) => this.id = id;

  void setAuthorId(String? id) => author_id = id;


  factory ArticlePost.fromJson(Map<String, dynamic>? data) {
    final String? id = data?['id'];
    final String? title = data?['title'];

    final String? date_string_created = data?['created_at'];
    final DateTime created_at = DateTime.parse(
        date_string_created ?? DateTime.utc(2001, 1, 1).toString());

    final String? content = data?['content'];
    final List<String>? categories =
    data?['categories'] is Iterable ? List.from(data?['categories']) : null;
    final String? author_id = data?['author_id'];
    final String? photoUrl = data?['photoUrl'];
    final List<String>? liked_users = data?['liked_users'] is Iterable
        ? List.from(data?['liked_users'])
        : null;

    return ArticlePost.only(
        id: id,
        author_id: author_id,
        title: title,
        content: content,
        created_at: created_at,
        categories: categories,
        photoUrl: photoUrl,
        liked_users: liked_users
    );
  }

  factory ArticlePost.fromDocumentSnapshot(
      DocumentSnapshot<Map<String, dynamic>> documentSnapshot) {
    return ArticlePost.fromJson(documentSnapshot.data());
  }

  Map<String, dynamic> toJson() => {
    if (id != null) 'id': id,
    if (title != null) 'title': title,
    if (created_at != null) 'created_at': created_at.toString(),
    if (content != null) 'content': content,
    if (categories != null) 'categories': categories,
    if (author_id != null) 'author_id': author_id,
    if (photoUrl != null) 'photoUrl': photoUrl,
    if (liked_users != null) 'liked_users': liked_users,
  };

  void addLikedUser(String userId) {
    if (liked_users == null) {
      liked_users = <String>[];
    }
    liked_users!.add(userId);
  }

  void addCategories(String category) {
    if (categories == null) {
      categories = <String>[];
    }
    categories!.add(category);
  }

  int get numberOfLike {
    return liked_users?.length ?? 0;
  }

  @override
  String toString() {
    return '${this.title} , ${this.content}';
  }

  static List<ArticlePost> getSampleArticlePostList() {
    var listCategory = <String>['Algorithm', 'Java'];
    var listAccount = <String>['id1', 'id2', 'id3'];
    List<ArticlePost> _post = <ArticlePost>[];
    _post.add(ArticlePost(
        '1',
        'What clothes we should use in the interview day',
        DateTime.now(),
        'Clothes are one of the easiest impressive point to the interviewers',
        listCategory,
        'authorid1',
        listAccount,));

    return _post;
  }
}

import 'package:Django/Home/model/UserModel.dart';

class CommentModel {
  int id;
  String content;
  UserModel Commenter;
  int mycomment;
  CommentModel({this.id,this.content,this.Commenter,this.mycomment});
  factory CommentModel.fromJson(Map<String, dynamic> json) {
    return CommentModel(
        id: json['id'],
        content: json['content'],
        Commenter: UserModel.fromJson(json['UID']),
        mycomment: json['mycomment']
    );
}
}
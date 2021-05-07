import 'package:Django/Home/model/CommentModel.dart';

import 'UserModel.dart';

class PostModel {
  int id;
  UserModel poster;
  int group_ID = 0;
  String content;
  String Time;
  String postImg;
  int mypost;
  List<CommentModel> Comments;
  PostModel({
    this.content,
    this.id,
    this.Comments,
    this.group_ID,
    this.mypost,
    this.poster,
    this.postImg,
    this.Time
  });
  factory PostModel.fromJson(Map<String, dynamic> json) {
    var list = json['post'];
    List<CommentModel> listComments;

    for (var i in list){
      try {
        listComments.add(CommentModel.fromJson(i));
      }
      catch(e) {
        // print(e.toString());
      }
    }
    // print(json);
    // List<CommentModel> comments = list.map((i) => CommentModel.fromJson(i)).toList();
    return PostModel(
        id: json['id'],
        content: json['content'],
        Comments: listComments,
        mypost: json['mypost'],
        poster:UserModel.fromJson(json['poster_ID']),
        postImg:json['postImg'],
        Time:json['Time']
    );
  }
}
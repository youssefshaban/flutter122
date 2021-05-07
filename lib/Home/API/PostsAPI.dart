import 'dart:convert';
import 'package:Django/Home/bloc/postsBloc/posts_bloc.dart';
import 'package:Django/Home/model/PostModel.dart';
import 'package:Django/core/sharedToken.dart';
import 'package:Django/models/UserModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../get_books_bloc.dart';

Future<List<PostModel>> GetPostsApi() async {
  final PostsBloc  _bloc = PostsBloc();
  _bloc.add(getPosts());
  try {
    String Token = await sharedToken().gettoken();
    _bloc.add(getPosts());
    final http.Response response = await http.get(
      'http://localhost:8000/api/posts/',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Token '+Token
      },

    );
    // print(response.body);
    if (response.statusCode == 200) {
      // print(response.body);
      var list = json.decode(response.body);
      List<PostModel> listPosts = [];
      for (var item in list){
        listPosts.add(PostModel.fromJson(item));
      }
       _bloc.add(successful());
        return listPosts;
       print(listPosts.length);
    } else {
      _bloc.add(Fail());
      throw Exception('Failed to get user data.');
    }
  }
  catch (e) {
    print(e.toString());
    _bloc.add(Fail());

  }
}
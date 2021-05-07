import 'dart:convert';
import 'package:Django/core/sharedToken.dart';
import 'package:Django/models/UserModel.dart';
import 'package:http/http.dart' as http;

import '../get_books_bloc.dart';

Future<bool> AddCommentAPI({String content,String postID}) async {
  try {
    print(content+postID);
    String Token = await sharedToken().gettoken();
    final http.Response response = await http.post(
      'http://localhost:8000/api/posts/addComment',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
        'Authorization' : 'Token '+Token
      },
      body: jsonEncode(<String, String>{
        'content': content,
        'postID':postID
      }),
    );
    // print(response.body);
    if (response.statusCode == 201) {
      // print(response.body.toString());
      return true;
    } else {
      // _bloc.add(userError(ErrorMsg: response.body.toString()));
      throw Exception('Failed to get user data.');
    }
  } catch (e) {
    // _bloc.add(userError());
    //todo: handel this case
    // throw Exception('can\'t connect to the server');
  }
}
import 'dart:convert';
import 'package:Django/models/UserModel.dart';
import 'package:http/http.dart' as http;

import '../get_books_bloc.dart';

Future<UserData> login({String username, String password}) async {
  final GetBooksBloc  _bloc = GetBooksBloc();
  try {
    _bloc.add(getUser());
    final http.Response response = await http.post(
      'http://localhost:8000/api/users/login',
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'username': username,
        'password': password
      }),
    );
    // print(response.body);
    if (response.statusCode == 200) {
      _bloc.add(userLoaded());
      // print(response.body.toString());
      return UserData.fromJson(json.decode(response.body));
    } else {
      _bloc.add(userError(ErrorMsg: response.body.toString()));
      throw Exception('Failed to get user data.');
    }
  } catch (e) {
    _bloc.add(userError());
    //todo: handel this case
    // throw Exception('can\'t connect to the server');
  }
}
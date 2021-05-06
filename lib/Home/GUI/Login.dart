import 'package:Django/Home/API/API.dart';
import 'package:Django/core/sharedToken.dart';
import 'package:Django/models/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../get_books_bloc.dart';
import 'Home.dart';


class LoginWebAdmin extends StatelessWidget {
  GetBooksBloc _bloc = GetBooksBloc();

  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldLoginKey =
    new GlobalKey<ScaffoldState>();
    void showInSnackBar(String value) {
      _scaffoldLoginKey.currentState
          .showSnackBar(new SnackBar(content: new Text(value)));
    }

    final TextEditingController _controllerPassword = TextEditingController();
    final TextEditingController _controllerPhonenumber =
    TextEditingController();
    // BlocBuilder<GetBooksBloc,GetBooksState>(
//                 // ignore: missing_return
//                 builder: (context, state) {
//                   if (state is GetBooksInitial){
//                     BlocProvider.of<GetBooksBloc>(context)
//                         .add(getbook());
//                     return Text('init');
//
//                   }
    final _formKey = GlobalKey<FormState>();
    return Scaffold(

        key: _scaffoldLoginKey,
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: BlocProvider(
            lazy: false,
            create: (BuildContext context) => _bloc,
            child: BlocBuilder<GetBooksBloc, GetBooksState>(
                bloc: _bloc,
                // ignore: missing_return
                builder: (context, state) {
                  if (state is GetBooksInitial){
                    return Container(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            Padding (
                              padding: const EdgeInsets.only(left:8.0,top:50,bottom: 12),
                              child:(Text('Login',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),)) ,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoTextField(
                                controller:_controllerPassword ,
                                prefix: Text('User Name'),
                                placeholder: 'enter your name',
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(width: 0.0, style: BorderStyle.none)),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoTextField(
                                controller:_controllerPhonenumber ,
                                prefix: Text('Password '),
                                placeholder: '*********',
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(width: 0.0, style: BorderStyle.none)),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                            ),

                            CupertinoButton(
                              child: Text('login'),
                              onPressed: () async {
                                _bloc.add(getUser());
                                if (_formKey.currentState.validate()) {
                                  try {
                                    UserData Login = await getAdminData(
                                        phoneNumber: _controllerPhonenumber.text
                                            .toString(),
                                        password:
                                        _controllerPassword.text.toString());

                                    if (Login.AccessToken != null) {
                                      await sharedToken().setToken(
                                          token: Login.AccessToken,
                                          dateTime: DateTime.now());
                                      print(Login.AccessToken);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Home(Login.AccessToken)),
                                      );
                                    } else {
                                      showInSnackBar('can\'t connect please check the connection and try again' );

                                      _bloc.add(userError(ErrorMsg: ""));
                                    }
                                  } catch (e) {
                                    showInSnackBar(e.toString());

                                    _bloc.add(userError(ErrorMsg: ""));
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }
                  if(state is getUser){
                    return Center(child: CupertinoActivityIndicator(),);
                  }
                  if(state is Error){
                    return Container(
                      child: Form(
                        key: _formKey,
                        child: ListView(
                          children: <Widget>[
                            Padding (
                              padding: const EdgeInsets.only(left:8.0,top:50,bottom: 12),
                              child:(Text('Login',style: TextStyle(fontSize:20,fontWeight: FontWeight.bold),)) ,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoTextField(
                                controller:_controllerPassword ,
                                prefix: Text('User Name '),
                                placeholder: 'enter your name',
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(width: 0.0, style: BorderStyle.none)),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: CupertinoTextField(
                                controller:_controllerPhonenumber ,
                                prefix: Text('Password '),
                                placeholder: '*********',
                                decoration: BoxDecoration(
                                    border:
                                    Border.all(width: 0.0, style: BorderStyle.none)),

                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                            ),

                            CupertinoButton(
                              child: Text('login'),
                              onPressed: () async {
                                _bloc.add(getUser());
                                if (_formKey.currentState.validate()) {
                                  try {
                                    UserData Login = await getAdminData(
                                        phoneNumber: _controllerPhonenumber.text
                                            .toString(),
                                        password:
                                        _controllerPassword.text.toString());

                                    if (Login.AccessToken != null) {
                                      await sharedToken().setToken(
                                          token: Login.AccessToken,
                                          dateTime: DateTime.now());
                                      print(Login.AccessToken);
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Home(Login.AccessToken)),
                                      );
                                    } else {
                                      showInSnackBar('can\'t connect please check the connection and try again' );

                                      _bloc.add(userError(ErrorMsg: ""));
                                    }
                                  } catch (e) {
                                    showInSnackBar('can\'t connect please check the connection and try again' );

                                    _bloc.add(userError(ErrorMsg: ""));
                                  }
                                }
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  }else{
                    return Center(child: CupertinoActivityIndicator(),);
                  }

                }),
          ),
        ));
  }
}
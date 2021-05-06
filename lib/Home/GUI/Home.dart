import 'package:Django/Home/GUI/Groups.dart';
import 'package:Django/Home/GUI/Post.dart';
import 'package:Django/Home/GUI/Profile.dart';
import 'package:Django/core/sharedToken.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Msgs.dart';
class Home extends StatefulWidget {
  String token;
  Home(this.token);

  @override
  _HomeState createState() => _HomeState(token);
}

class _HomeState extends State<Home> {
  String logedIn = '';

  @protected
  @mustCallSuper
  void initState()  {
    check();
  }
  Future<void> check ()async{
    if(sharedToken().gettoken() != null){
      // logedIn =  await prefs.get('token');
      print( sharedToken().gettoken());
      // print( '-----');
    }
  }
  String Token ;
  _HomeState(this.Token);
  int _selectedIndex = 0;
  TextStyle optionStyle =
  TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  List<Widget> _widgetOptions = [
    Posts(),
    Groups(),
    Msgs(),
    Profile()
  ];

  Future<void> _onItemTapped(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // await prefs.setString('token', Token);
    print(await prefs.get('token'));
    setState(()  {
      // logedIn = await sharedToken().gettoken();

      // print('----'+logedIn+'=====');
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.auto_awesome_motion),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.group),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.mark_as_unread),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.account_circle),
            label: '',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.blueAccent,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,
        iconSize: 30,
        selectedFontSize: 10,
      ),




    );
  }
}

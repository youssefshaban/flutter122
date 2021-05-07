import 'package:Django/Home/model/UserModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class UserProfile extends StatelessWidget {
  UserModel user ;
  UserProfile({this.user});
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: SafeArea(
        child: ListView(
          children: [
            Container(
              height: 220,
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(image:NetworkImage("http://localhost:8000${user.profileImage}"),fit: BoxFit.fill),


                    )
                    ,
                    height: 150,
                    // color: Colors.blueAccent,
                  ),
                  Positioned(
                    top: 83,
                    left: 147,
                    child: Container(
                        child:Center(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: CircleAvatar(
                                radius: 63,
                                backgroundColor: Colors.white,

                            ),
                          ),
                        )),
                  ),
                  Positioned(
                    top: 85,
                    left: 150,
                    child: Container(
                      child:Center(
                        child: Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: CircleAvatar(
                            radius: 60,
                           backgroundColor: Colors.brown.shade800,

                    backgroundImage:
                    NetworkImage("http://localhost:8000${user.profileImage}")
                    ),
                        ),
                      )),
                  ),
                ],
              ),
            ),
            Container(
                color: CupertinoColors.darkBackgroundGray,
              child: Column(children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(user.name),
                )
              ],),
              ),

          ],
        ),
      ),
    );
  }
}

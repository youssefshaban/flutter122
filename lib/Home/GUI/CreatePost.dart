import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CreatePostContainer extends StatelessWidget {
  // final User currentUser;
  //
  // const CreatePostContainer({
  //   Key key,
  //   @required this.currentUser,
  // }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return CupertinoPageScaffold(
      child: Card(
        color: CupertinoColors.secondaryLabel,
        margin: EdgeInsets.symmetric(horizontal:  0.0),
        elevation:  0.0,
        shape: null,
        child: Container(
          padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
          // color: Colors.white,
          child: Column(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    // backgroundColor: Colors.brown.shade800,
                    child: Text('AH'),
                  ),
                  const SizedBox(width: 8.0),
                  Expanded(
                    child: CupertinoTextField(
                      placeholderStyle: TextStyle(
                        color: CupertinoColors.white
                      ),
                      placeholder: 'what\'s in your maind',
                      enabled: false,
                    ),
                  )
                ],
              ),
              const Divider(height: 10.0, thickness: 0.5),
              Container(
                height: 40.0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    FlatButton.icon(
                      icon: const Icon(
                        Icons.analytics,
                        color: Colors.red,
                      ),
                      label: Text('Create new Post',style: TextStyle(
                          color: CupertinoColors.white
                      ),),
                    ),



                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
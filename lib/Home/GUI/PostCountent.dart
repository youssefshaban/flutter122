import 'package:Django/Home/API/AddCommentAPI.dart';
import 'package:Django/Home/model/CommentModel.dart';
import 'package:Django/Home/model/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'UserProfile.dart';
class PostContent extends StatefulWidget {
  PostModel post;
  PostContent({this.post});

  @override
  _PostContentState createState() => _PostContentState(post: post);
}

class _PostContentState extends State<PostContent> {
  PostModel post;
  _PostContentState({this.post});
  @override
  Widget build(BuildContext context) {
    final TextEditingController _controllerContent = TextEditingController();

    bool profileImage = false;
    if (widget.post.poster.profileImage!='null')
      profileImage = true;


    return CupertinoPageScaffold(
      child: SafeArea(
        child: Stack(
          children: [
            Container(
              // color: CupertinoColors.darkBackgroundGray,

              child: Padding(

                padding: const EdgeInsets.all(8.0),
                child: Container(

                  child: SizedBox(
                    height: MediaQuery.of(context).size.height-30,
                    child: ListView(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      UserProfile(user: widget.post.poster,)),
                            );
                          },
                          child: Row(
                            children: [
                              profileImage ?
                              CircleAvatar(
                                // backgroundColor: Colors.brown.shade800,

                                backgroundImage:
                                NetworkImage("http://localhost:8000${widget.post.poster.profileImage}")

                                ,
                              )       :
                              CircleAvatar(
                                // backgroundColor: Colors.brown.shade800,
                                child: Text(widget.post.poster.name.substring(0,2)),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(widget.post.poster.name,style: TextStyle(
                                    color: CupertinoColors.white
                                )),
                              ),

                              Spacer()

                            ],
                          ),
                        ),

                        GestureDetector(
                            onTap: (){
                              print('content');
                            },
                            child: Container(
                                // color: Colors.white10
                                width:MediaQuery.of(context).size.width,child: Center(child: Text(widget.post.content)))),
                        post.postImg!=null?
                        Container(
                          width: MediaQuery.of(context).size.width,
                          height: 300,
                          decoration: BoxDecoration(
                              image: DecorationImage(image: NetworkImage('http://localhost:8000'+post.postImg.toString()),
                                  fit: BoxFit.contain)
                          ),
                        ):Container(),
                        Divider(),
                        Row(
                          children: [
                            Container(child: ElevatedButton(onPressed: (){
                              print('like');
                            },child: Icon(Icons.add_chart),),width: MediaQuery.of(context).size.width-37,),

                          ],
                        ),
                 SizedBox(
                     height: MediaQuery.of(context).size.height-600,
                     child: ListView(children: widget.post.Comments.reversed.map((item) {

                         return Container(child:
                         Card(
                           color: CupertinoColors.secondaryLabel,
                           child: ListTile(title:   GestureDetector(
                             onTap: (){
                               Navigator.push(
                                 context,
                                 MaterialPageRoute(
                                     builder: (context) =>
                                         UserProfile(user: item.Commenter,)),
                               );
                             },
                             child: Row(
                               children: [
                                 profileImage ?
                                 CircleAvatar(
                                   // backgroundColor: Colors.brown.shade800,

                                   backgroundImage:
                                   NetworkImage("http://localhost:8000${item.Commenter.profileImage}")

                                   ,
                                 )       :
                                 CircleAvatar(
                                   // backgroundColor: Colors.brown.shade800,
                                   child: Text(item.Commenter.name.substring(0,2)),
                                 ),
                                 Padding(
                                   padding: const EdgeInsets.all(8.0),
                                   child: Text(item.Commenter.name,style: TextStyle(
                       color: CupertinoColors.white
                       )),
                                 ),
                                 Spacer()

                               ],
                             ),
                           ),
                           subtitle: Padding(
                             padding: const EdgeInsets.all(8.0),
                             child: Center(child: Text(item.content,style: TextStyle(
                                 color: CupertinoColors.white
                             ),),),
                           ),),

                         ),
                       );
                     }).toList(),

                     ),
                 ),



                      ],

                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 70,
                  width: 400,
                  child: Container(

                    child: Row(
                      children: [
                        SizedBox(
                          height: 70,
                          width: MediaQuery.of(context).size.width-70,
                          child: CupertinoTextField(
                            autofocus: true,
                            controller: _controllerContent,
                            placeholder: "add comment",
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.newline,
                            minLines: 3,
                            maxLines: 9,
                          ),
                        ),
                        Spacer(),
                        GestureDetector(
                            onTap: () async{
                              if (!_controllerContent.text.isEmpty){
                                bool Added = await AddCommentAPI(
                                    content: _controllerContent.text.toString(),
                                    postID: widget.post.id.toString()

                                );
                                setState(() {
                                  post.Comments.add(CommentModel(content: _controllerContent.text.toString(),
                                      mycomment: 1,
                                      Commenter: post.poster,
                                      id:post.Comments.length+1

                                  ),);
                                });

                                _controllerContent.clear();
                              }

                            },
                            child: Icon(Icons.send))
                      ],
                    ),
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}


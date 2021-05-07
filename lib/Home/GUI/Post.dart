import 'package:Django/Home/API/PostsAPI.dart';
import 'package:Django/Home/bloc/postsBloc/posts_bloc.dart';
import 'package:Django/Home/model/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scrollable_panel/scrollable_panel.dart';


import 'CreatePost.dart';
class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  List<PostModel> posts;
  PanelController _panelController = PanelController();
  PostsBloc _bloc = PostsBloc();
  @override
  void initState() {
   getData();
   super.initState();
  }
  void getData() async{
    posts = await GetPostsApi();
    _bloc.add(successful());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [

            Column(
              children: [
                GestureDetector(onTap:(){
                  print('_panelController.expand()');
                  if(_panelController.isExpand)
                    _panelController.close();
                  else
                    _panelController.expand();
                },child: CreatePostContainer()),




                Padding (
                  padding: const EdgeInsets.all(8.0),
                  child: BlocProvider(
                    create: (BuildContext context) => _bloc,
                    child: BlocBuilder<PostsBloc, PostsState>(
                      bloc: _bloc,
                        builder: (context, state) {
                        if (state is PostsInitial){
                          return Center(child: CupertinoActivityIndicator(),);
                        }
                        if (state is Loaded){
                          return  SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height-250,
                              child: ListView(children: posts.map((item) =>
                                  Card(

                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Container(
                                          width: 300,
                                          height: 150,
                                          child: Column(
                                            children: [
                                              Row(
                                                children: [
                                                  CircleAvatar(
                                                    backgroundColor: Colors.brown.shade800,
                                                    child: Text(item.poster.name.substring(0,2)),
                                                  ),
                                                  Padding(
                                                    padding: const EdgeInsets.all(8.0),
                                                    child: Text(item.poster.name),
                                                  ),
                                                  Spacer()

                                                ],
                                              ),
                                              Text(item.content),
                                              Divider(),
                                              Row(
                                                children: [
                                                  Container(child: ElevatedButton(onPressed: (){
                                                    print('like');
                                                  },child: Icon(Icons.add_chart),),width: MediaQuery.of(context).size.width/2.3,),
                                                  Spacer(),
                                                  Container(child: ElevatedButton(onPressed: (){
                                                    print('comment');

                                                  },child: Text('comment'),),width: MediaQuery.of(context).size.width/2.3,),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),

                              ).toList()));
                        }
                        else {
                          return Center(child: CupertinoActivityIndicator(),);

                        }
    }
                  ),


                  ),
                )],
            ),
            ScrollablePanel(
              defaultPanelState: PanelState.close,
              controller: _panelController,
              onExpand: () => print('onExpand'),
              builder: (context, controller) {
                return SingleChildScrollView(
                  controller: controller,
                  child:_SecondView()
                );
              },
            ),



          ],
        ),
      ),
    );
  }


}
class _SecondView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    const double circularBoxHeight = 16.0;
    final Size size = MediaQuery.of(context).size;
    return LayoutBuilder(
      builder: (context, constraints) {
        return ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: size.height + kToolbarHeight + 44.0,
          ),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(circularBoxHeight), topRight: Radius.circular(circularBoxHeight)),
              border: Border.all(color: Colors.grey[200]),
            ),
            child: SizedBox(
              height: 200,
              child: Column(

                children: [
                  Text('Content'),
                  Container(
              decoration: BoxDecoration(
                color: Colors.grey[200],
                border: Border.all(color: Colors.grey[200]),
              ),
                    child: Card(
                      color: Colors.grey[200],
                      child: SizedBox(
                        width: 400,
                        height: 300,
                        child: Column(
                          children: [
                            SizedBox(
                              width: 400,
                              height: 200,
                              child: Row(
                                children: [
                                  Column(
                                    children: [

                                      CircleAvatar(
                                        backgroundColor: Colors.brown.shade800,
                                        child: Text('AH'),
                                      ),
                                      Spacer()
                                    ],

                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SizedBox(
                                      width: 340,
                                      height: 200,
                                      child: CupertinoTextField(

                                        placeholder: "feel free to write what you want",
                                        keyboardType: TextInputType.multiline,
                                        textInputAction: TextInputAction.newline,
                                        minLines: 3,
                                        maxLines: 9,
                                      ),
                                    ),
                                  ),

                                ],
                              ),
                            ),
                            SizedBox(
                              child: OutlinedButton(child: Text("send"),onPressed: (){
                                print ('send');
                              },style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.grey[200]), ),),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            )
          ),
        );
      },
    );
  }}

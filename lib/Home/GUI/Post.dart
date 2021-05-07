import 'package:Django/Home/API/AddLikeAPI.dart';
import 'package:Django/Home/API/CreatePostAPI.dart';
import 'package:Django/Home/API/DeletePostAPI.dart';
import 'package:Django/Home/API/PostsAPI.dart';
import 'package:Django/Home/API/removeLikeAPI.dart';
import 'package:Django/Home/GUI/PostCountent.dart';
import 'package:Django/Home/GUI/UserProfile.dart';
import 'package:Django/Home/bloc/postsBloc/posts_bloc.dart';
import 'package:Django/Home/model/PostModel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:scrollable_panel/scrollable_panel.dart';
import 'package:image_downloader/image_downloader.dart';


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
    RefreshController _refreshController =
    RefreshController(initialRefresh: false);

    void _onRefresh() async{
      await Future.delayed(Duration(milliseconds: 1000));
      _bloc.add(getPosts());

      getData();      // if failed,use refreshFailed()
      _refreshController.refreshCompleted();
    }

    void _onLoading() async{
      // await Future.delayed(Duration(milliseconds: 1000));

      if(mounted)
      _refreshController.loadComplete();
    }

    const double circularBoxHeight = 90.0;
    final Size size = MediaQuery.of(context).size;
    final TextEditingController _controllerContent = TextEditingController();

    return CupertinoPageScaffold(
      child: SafeArea(
        child: SafeArea(
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




                  BlocProvider(
                    create: (BuildContext context) => _bloc,
                    child: BlocBuilder<PostsBloc, PostsState>(
                      bloc: _bloc,
                        builder: (context, state) {
                        if (state is PostsInitial){
                          return Center(child: CupertinoActivityIndicator(),);
                        }
                        if (state is Loaded){

                          return  buildSizedBox(context, _refreshController, _onRefresh, _onLoading);
                        }
                        else {
                          return Center(child: CupertinoActivityIndicator(),);

                        }
    }
                  ),


                  )],
              ),
              ScrollablePanel(
                defaultPanelState: PanelState.close,
                controller: _panelController,
                maxPanelSize: 0.4,
                onExpand: () => print('onExpand'),
                builder: (context, controller) {
                  return SingleChildScrollView(
                    controller: controller,
                    child: LayoutBuilder(
                      builder: (context, constraints) {
                        return ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: size.height + kToolbarHeight + 44.0,
                          ),
                          child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.grey[200],
                                borderRadius: const BorderRadius.only(topLeft: Radius.circular(circularBoxHeight), topRight: Radius.circular(circularBoxHeight)),
                                // border: Border.all(color: Colors.grey[200]),
                              ),
                              child: SizedBox(
                                height: 200,
                                child: Column(

                                  children: [
                                    // Text(''),
                                    Container(
                                      decoration: BoxDecoration(
                                        // color: Colors.grey[200],
                                        // border: Border.all(color: Colors.grey[200]),
                                      ),
                                      child: Card(
                                        color: CupertinoColors.secondaryLabel,
                                        // color: Colors.grey[200],
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
                                                          // backgroundColor: Colors.brown.shade800,
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
                                                          controller: _controllerContent,
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
                                                child: OutlinedButton(child: Text("send"),onPressed: () async {

                                                  if(_controllerContent.text.isEmpty){
                                                    // showInSnackBar('fields can\'t be empty');

                                                  }else {
                                                    try {
                                                      bool success = await CreatePostAPI(
                                                          content: _controllerContent.text.toString()
                                                      );
                                                      if (success){
                                                        setState(() {
                                                          _panelController.close();
                                                          _bloc.add(getPosts());
                                                          getData();


                                                        });
                                                        // await GetPostsApi();
                                                      }

                                                    }catch(e){}
                                                  }

                                                },style: ButtonStyle(
                                                  // backgroundColor:MaterialStateProperty.all<Color>(Colors.grey[200]),
                                                   ),),
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
                    )
                  );
                },
              ),

            ],
          ),
        ),
      ),
    );

  }

  SizedBox buildSizedBox(BuildContext context, RefreshController _refreshController, void _onRefresh(), void _onLoading()) {
    return SizedBox(
                            width: MediaQuery.of(context).size.width,
                            height: MediaQuery.of(context).size.height-250,
                            child: Padding(
                              padding: const EdgeInsets.only(top:8.0),
                              child: buildSmartRefresher(_refreshController, _onRefresh, _onLoading, context),
                            ));
  }

  SmartRefresher buildSmartRefresher(RefreshController _refreshController, void _onRefresh(), void _onLoading(), BuildContext context) {
    return SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: false,
                                controller: _refreshController,
                                onRefresh: _onRefresh,
                                onLoading: _onLoading,
                                header: WaterDropHeader(),
                                footer: CustomFooter(
                                  builder: (BuildContext context,LoadStatus mode){
                                    Widget body ;
                                    if(mode==LoadStatus.idle){
                                      body =  Text("pull up load",style: TextStyle(color: CupertinoColors.white),);
                                    }
                                    else if(mode==LoadStatus.loading){
                                      body =  CupertinoActivityIndicator();
                                    }
                                    else if(mode == LoadStatus.failed){
                                      body = Text("Load Failed!Click retry!",style: TextStyle(color: CupertinoColors.white),);
                                    }
                                    else if(mode == LoadStatus.canLoading){
                                      body = Text("release to load more",style: TextStyle(color: CupertinoColors.white),);
                                    }
                                    else{
                                      body = Text("No more Data",style: TextStyle(color: CupertinoColors.white),);
                                    }
                                    return Container(
                                      height: 55.0,
                                      child: Center(child:body),
                                    );
                                  },
                                ),
                                child: ListView(children: posts.reversed.map((item) {
                                  bool profileImage = false;
                                  if (item.poster.profileImage!='null')
                                    profileImage = true;

                                  return Hero(
                                    tag: item.id,
                                    child: Padding(
                                      padding: const EdgeInsets.only(top:8.0),
                                      child: Container(
                                         color: CupertinoColors.secondaryLabel,
                                            child: Padding(
                                              padding: const EdgeInsets.all(8.0),
                                              child: Container(
                                                width: 300,
                                                // height: 150,
                                                child: Column(
                                                  children: [
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  UserProfile(user: item.poster,)),
                                                        );
                                                      },
                                                      child: Row(
                                                        children: [
                                                profileImage ?
                                                          CircleAvatar(
                                                            // backgroundColor: Colors.brown.shade800,

                                                            backgroundImage:
                                                            NetworkImage("http://localhost:8000${item.poster.profileImage}")

                                                   ,
                                                          )       :
                                                CircleAvatar(
                                                // backgroundColor: Colors.brown.shade800,
                                                child: Text(item.poster.name.substring(0,2)),
                                              ),
                                                          Padding(
                                                            padding: const EdgeInsets.all(8.0),
                                                            child: Text(item.poster.name),
                                                          ),
                                                          Spacer(),
                                                          item.mypost==1?
                                                          GestureDetector(onTap:(){
                                                            buttom(context,item.id.toString());
                                                          },child: Icon(CupertinoIcons.ellipsis))
                                                              :Container()

                                                        ],
                                                      ),
                                                    ),
                                                    GestureDetector(
                                                        onTap: (){
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PostContent(post: item,)),
                                                          );
                                                        },
                                                        child: Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: Container(

                                                              width:MediaQuery.of(context).size.width,child: Text(item.content)),
                                                        )),
                                                    item.postImg!=null?
                                                        GestureDetector(
                                                          onTap: (){
                                                            d(context,item.postImg);
                                                          },
                                                          child: Container(
                                                            width: MediaQuery.of(context).size.width,
                                                            height: 300,
                                                            decoration: BoxDecoration(
                                                                image: DecorationImage(image: NetworkImage('http://localhost:8000'+item.postImg.toString()),
                                                                    fit: BoxFit.fitHeight)
                                                            ),
                                                          ),
                                                        ):Container(),
                                                    Divider(),
                                                    Row(
                                                      children: [
                                                        item.liked!=1?
                                                        Container(child: ElevatedButton(onPressed: (){
                                                          AddLikeAPI(postID: item.id.toString());
                                                          setState(() {
                                                            _bloc.add(getPosts());
                                                            getData();
                                                          });
                                                        },child: Text('like'),),width: MediaQuery.of(context).size.width/2.3,):
                                                        Container(child: ElevatedButton(onPressed: (){
                                                          removeLikeAPI(postID: item.id.toString());
                                                          setState(() {
                                                            _bloc.add(getPosts());
                                                            getData();
                                                          });
                                                        },child: Text('unlike'),style: ButtonStyle(
                                                          backgroundColor: MaterialStateProperty.resolveWith<Color>(
                                                            (Set<MaterialState> states) {
                                                              return CupertinoColors.destructiveRed;
                                                            }
                                                          )
                                                        ),),width: MediaQuery.of(context).size.width/2.3,),
                                                        Spacer(),
                                                        Container(child: ElevatedButton(onPressed: (){

                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                                builder: (context) =>
                                                                    PostContent(post: item,)),
                                                          );
                                                        },child: Text('comment'),),width: MediaQuery.of(context).size.width/2.3,),
                                                    ]),
                                                    !item.Comments.isEmpty?
                                                    GestureDetector(
                                                      onTap: (){
                                                        Navigator.push(
                                                          context,
                                                          MaterialPageRoute(
                                                              builder: (context) =>
                                                                  PostContent(post: item,)),
                                                        );
                                                      },
                                                      child: SizedBox(
                                                        height: 130,
                                                        child:  Container(child:
                                                          Card(
                                                            color: CupertinoColors.secondaryLabel,
                                                            child: ListTile(title:   GestureDetector(
                                                              onTap: (){
                                                                Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                      builder: (context) =>
                                                                          UserProfile(user: item.Comments.first.Commenter,)),
                                                                );
                                                              },
                                                              child: Row(
                                                                children: [
                                                                  profileImage ?
                                                                  CircleAvatar(
                                                                    // backgroundColor: Colors.brown.shade800,

                                                                    backgroundImage:
                                                                    NetworkImage("http://localhost:8000${item.Comments.first.Commenter.profileImage}")

                                                                    ,
                                                                  )       :
                                                                  CircleAvatar(
                                                                    // backgroundColor: Colors.brown.shade800,
                                                                    child: Text(item.Comments.first.Commenter.name.substring(0,2)),
                                                                  ),
                                                                  Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: Text(item.Comments.first.Commenter.name,style: TextStyle(
                                                                        color: CupertinoColors.white
                                                                    )),
                                                                  ),
                                                                  Spacer()

                                                                ],
                                                              ),
                                                            ),
                                                              subtitle: Padding(
                                                                padding: const EdgeInsets.all(8.0),
                                                                child: Center(child: Text(item.Comments.first.content,style: TextStyle(
                                                                    color: CupertinoColors.white
                                                                ),),),
                                                              ),),

                                                          ),
                                                          ),

                                                        ),
                                                    ):
                                                    Container(),

                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                    ),
                                  );}

                                ).toList()),
                              );
  }

  Widget buttom (context,id){
    bool x = false;
    showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) => CupertinoActionSheet(
        title: const Text('Actions'),
        // message: const Text('Message'),
        actions: [
          CupertinoActionSheetAction(
            child: const Text('edit post'),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          CupertinoActionSheetAction(
            isDestructiveAction: true,
            child: const Text('DELETE POST'),
            onPressed: () {

              showCupertinoDialog(
                  context: context,
                  builder: (_) => CupertinoAlertDialog(
                    // title: Text("This is the title"),
                    content: Container(
                      height: 200,
                      child: Center(
                   child: x?Text('deleted'):CupertinoActivityIndicator()
                      ),
                    ),
                  ));
              // Navigator.pop(context);
              void c () async{

                  await DeletePostAPI(postID: id);




              }
              c();
              setState(() {

                  // _panelController.close();
                  _bloc.add(getPosts());
                  getData();



                x = true;
              });


              Navigator.pop(context);
              Navigator.pop(context);
            },

          )
        ],
      ),
    );
  }


  Widget d (context,image){
    showCupertinoDialog(
        context: context,
        builder: (_) => CupertinoAlertDialog(
          // title: Text("This is the title"),
          content: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
                image: DecorationImage(image: NetworkImage('http://localhost:8000'+image.toString()),
                    fit: BoxFit.contain)
            ),
          ),
          actions: [
            // Close the dialog
            CupertinoButton(
                child: Text('Close'),
                onPressed: () {
                  Navigator.of(context).pop();
                }),
            CupertinoButton(
              child: Text('Save'),
              onPressed: () async {
                // Do something
                try {
                  // Saved with this method.
                  var imageId = await ImageDownloader.downloadImage('http://localhost:8000'+image.toString());
                  if (imageId == null) {
                    return;
                  }

                  // Below is a method of obtaining saved image information.
                  var fileName = await ImageDownloader.findName(imageId);
                  var path = await ImageDownloader.findPath(imageId);
                  var size = await ImageDownloader.findByteSize(imageId);
                  var mimeType = await ImageDownloader.findMimeType(imageId);
                  Navigator.of(context).pop();
                } on PlatformException catch (error) {
                  print(error);
                  Navigator.of(context).pop();

                }
              },
            )
          ],
        ));




  }







}


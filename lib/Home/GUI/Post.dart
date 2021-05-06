import 'package:Django/Home/GUI/Profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:scrollable_panel/scrollable_panel.dart';


import 'CreatePost.dart';
class Posts extends StatefulWidget {
  @override
  _PostsState createState() => _PostsState();
}

class _PostsState extends State<Posts> {
  PanelController _panelController = PanelController();

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




                Center(child: Container(child: Text('Posts page'),)
                ),
              ],
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
              color: Colors.grey,
              borderRadius: const BorderRadius.only(topLeft: Radius.circular(circularBoxHeight), topRight: Radius.circular(circularBoxHeight)),
              border: Border.all(color: Colors.grey),
            ),
            child: SizedBox(
              height: 200,
              child: Column(

                children: [
                  Text('Content'),
                  Container(
              decoration: BoxDecoration(
                color: Colors.white,
                border: Border.all(color: Colors.white),
              ),
                    child: Card(
                      child: SizedBox(
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
                    ),
                  ),
                  SizedBox(
                    child: OutlinedButton(child: Text("send"),onPressed: (){
                      print ('send');
                    },style: ButtonStyle(backgroundColor:MaterialStateProperty.all<Color>(Colors.white10), ),),
                  )
                ],
              ),
            )
          ),
        );
      },
    );
  }}

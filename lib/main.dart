import 'package:flutter/material.dart';


import 'Home/GUI/Home.dart';
import 'Home/GUI/Login.dart';

import 'core/sharedToken.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  String _logedIn;
  @protected
  @mustCallSuper
  void initState()  {
    check();
  }
  Future<void> check ()async{
    if(sharedToken().gettoken() != null){
      _logedIn = await sharedToken().gettoken();
      print( sharedToken().gettoken());
      print( '-----');
    }
  }
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,

        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: _logedIn==null?LoginWebAdmin():Home(_logedIn),

      // child: MyHomePage(title: 'new',),





      // MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key key, this.title}) : super(key: key);
//
//
//   final String title;
//
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {




//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//
//         title: Text(widget.title),
//       ),
//       body: Center(
//         child:
//             BlocBuilder<GetBooksBloc,GetBooksState>(
//                 // ignore: missing_return
//                 builder: (context, state) {
//                   if (state is GetBooksInitial){
//                     BlocProvider.of<GetBooksBloc>(context)
//                         .add(getbook());
//                     return Text('init');
//
//                   }
//                   if (state is Loading){
//                    return CircularProgressIndicator();
//                   }
//                   if (state is DataLoadedSuccessfully){
//                     return FlutterLogo(size: 90,);
//                   }
//                 }
//                 ),
//       ),
//  floatingActionButton: FloatingActionButton(
//      onPressed: (){
//        BlocProvider.of<GetBooksBloc>(context)
//            .add(getbook());
//      },
//      child: Icon(Icons.ac_unit))
//
//  // This trailing comma makes auto-formatting nicer for build methods.
//     );
//   }
// }

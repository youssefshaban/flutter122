import 'package:flutter/material.dart';
class customCalors{
  TextStyle buildTextStyle(BuildContext context) => TextStyle(color: Theme.of(context).textSelectionColor);
  TextStyle buildTextStyleFix(BuildContext context) => TextStyle(color: Theme.of(context).accentColor);
  Color ButtomCollor(BuildContext context)=>Theme.of(context).accentColor;
}
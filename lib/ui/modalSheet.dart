import 'package:flutter/material.dart';
import 'package:newtest/card/cardConst.dart';
import 'package:newtest/state/gameState.dart';
import 'package:provider/provider.dart';

class ColorAskingModalSheet extends StatefulWidget {

  final callback;
  ColorAskingModalSheet(this.callback);

  @override
  _ColorAskingModalSheetState createState() => _ColorAskingModalSheetState();
}

class _ColorAskingModalSheetState extends State<ColorAskingModalSheet> {
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Text('CHOOSE A COLOR. PLEASE BE SURE ABOUT IT'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(height: 100,width: 100,color: blue,child: FlatButton(onPressed: (){setState(() {
                  color = blue;
                });}, child: null),),
                Container(height: 100,width: 100,color: orange,child: FlatButton(onPressed: (){setState(() {
                  color = orange;
                });}, child: null),),
                Container(height: 100,width: 100,color: red,child: FlatButton(onPressed: (){setState(() {
                  color = red;
                });}, child: null),),
                Container(height: 100,width: 100,color: green,child: FlatButton(onPressed: (){setState(() {
                  color = green;
                });}, child: null),),
              ],
            ),
            RaisedButton(onPressed: (){
              widget.callback(color);
              Navigator.of(context).pop();
            },child: Text('APPLY COLOR'),color: color,)
          ],
        ),
    );
  }
}
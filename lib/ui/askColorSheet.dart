import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newtest/card/cardConst.dart';

class ColorAskingModalSheet extends StatefulWidget {
  final callback;

  ColorAskingModalSheet(this.callback);

  @override
  _ColorAskingModalSheetState createState() => _ColorAskingModalSheetState();
}

class _ColorAskingModalSheetState extends State<ColorAskingModalSheet> {
  Color color;

  void showDialog(BuildContext context) {
    showCupertinoDialog(
      context: context,
      builder: (context) => CupertinoAlertDialog(
        title: Text('Y U NO PICK COLOR'),
        content: Container(child: Text('PLEASE PICK A COLOR'),margin: EdgeInsets.only(top: 20),),
        actions: <Widget>[CupertinoDialogAction(child: Text('OK'),onPressed: (){
          Navigator.of(context).pop();
        },)],
      ),
    );
  }

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
              Container(
                height: 100,
                width: 100,
                color: blue,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        color = blue;
                      });
                    },
                    child: null),
              ),
              Container(
                height: 100,
                width: 100,
                color: orange,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        color = orange;
                      });
                    },
                    child: null),
              ),
              Container(
                height: 100,
                width: 100,
                color: red,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        color = red;
                      });
                    },
                    child: null),
              ),
              Container(
                height: 100,
                width: 100,
                color: green,
                child: FlatButton(
                    onPressed: () {
                      setState(() {
                        color = green;
                      });
                    },
                    child: null),
              ),
            ],
          ),
          RaisedButton(
            onPressed: () {
              if(color==null){
                showDialog(context);
                return;
              }
              widget.callback(color);
              Navigator.of(context).pop();
            },
            child: Text('APPLY COLOR'),
            color: color,
          )
        ],
      ),
    );
  }
}

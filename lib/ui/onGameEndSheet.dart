import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class OnGameEndSheet extends StatefulWidget {
  final String nameOfWinner;

  OnGameEndSheet(this.nameOfWinner);

  @override
  _OnGameEndSheetState createState() => _OnGameEndSheetState();
}

class _OnGameEndSheetState extends State<OnGameEndSheet> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CupertinoAlertDialog(
        content: Text('THE GAME IS WON BY : ${widget.nameOfWinner}'),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.of(context).pop();
          },child: Text('OKAY'),),
        ],
      ),
    );
  }
}

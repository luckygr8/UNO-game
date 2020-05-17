import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final Function todo;
  final child;

  Button(this.todo,this.child);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      padding: EdgeInsets.all(0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
         color: Colors.amber,
      ),
      child: FlatButton(onPressed: todo, child:child),
    );
  }
}
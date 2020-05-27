import 'package:flutter/material.dart';

class Button extends StatelessWidget {

  final Function todo;
  final child;
  final Color color;

  Button(this.todo,this.child,this.color);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
         border: Border.all(width: 2,color: Colors.black),
         color: color,
      ),
      child: Center(child: FlatButton(onPressed: todo, child:child)),
    );
  }
}
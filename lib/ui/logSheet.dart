import 'package:flutter/material.dart';

class LogSheet extends StatelessWidget {

  final List<Widget> items;
  LogSheet(this.items);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.pink,
      child: Center(
          child: ListWheelScrollView(
          itemExtent: 100,
          children: List<Widget>.from(items.reversed),
      ),),
    );
  }
}


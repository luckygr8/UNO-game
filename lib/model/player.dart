import 'package:flutter/material.dart';

class Player{
  final int id;
  final String name;
  List<Widget> ownList = [];
  bool hasTurn=false;
  Player(this.id , this.name);

  String toString(){
    return "$name - $id - $hasTurn - $ownList";
  }
}

class CardData{
  final String value;
  final Color color;

  CardData({this.value,this.color});

  String toString(){
    return "$value + ${color.toString()}";
  }
}
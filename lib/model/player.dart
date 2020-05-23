import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';

class Player{
  final int id;
  final String name;
  List<UNOcard> ownList = [];
  bool hasTurn=false;
  Player(this.id , this.name);

  String toString(){
    return "$name - $id - $hasTurn";
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
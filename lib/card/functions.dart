import 'package:flutter/material.dart';
import 'package:newtest/card/card.dart';
import 'package:newtest/card/cardConst.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/state/gameState.dart';

// 1 for regular colored , 2 for reverse , 3 for block , 4 for 2plus , 5 for wild , 6 for 4plus
int ftypeOfCard(Widget card) {
  if (card is RegularUnoCard) {
    switch (card.value) {
      case reverse:
        return 2;
      case block:
        return 3;
      case plus2:
        return 4;
      default:
        return 1;
    }
  } else if (card is SpecialUnoCard) {
    switch (card.value) {
      case wild:
        return 5;
      case plus4:
        return 6;
    }
  }
  return -1;
}

// red 1 blue 2 green 3 orange 4
Color fgetColorOfTheCard(Widget card) {
  if (card is RegularUnoCard) {
    if (card.color == blue) return blue;
    if (card.color == red) return red;
    if (card.color == green) return green;
    if (card.color == orange) return orange;
  }
  return null;
}

bool fisValidMove(CardData data, Widget cardOnTop, GameState gameState) {
  if (data.value == plus4 || data.value == wild) {
    // wild or 4plus
    print('wild or 4plus');
    return true;
  }
  if (gameState.ggameColor == data.color) {
    // color is same
    print('color matches the game color');
    return true;
  }
  if (data.value == (cardOnTop as RegularUnoCard).value) {
    // value was same
    print('top value is same');
    return true;
  }
  print('no match');
  return false;
}

bool fisValidMoveComp(CardData data, Widget cardOnTop, GameState gameState) {
  if (data.value == plus4 || data.value == wild) {
    // wild or 4plus
    print('wild or 4plus');
    return true;
  }
  if (gameState.ggameColor == data.color) {
    // color is same
    print('color matches the game color');
    return true;
  }
  if (data.value == (cardOnTop as RegularUnoCard).value) {
    // value was same
    print('top value is same');
    return true;
  }
  print('no match');
  return false;
}

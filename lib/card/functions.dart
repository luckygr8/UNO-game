import 'package:flutter/material.dart';
import 'package:flutter_vibrate/flutter_vibrate.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';

int getTypePriority(String cardType) {
  switch (cardType) {
    case CardTypes.PLUS4:
      return 6;
    case CardTypes.WILD:
      return 5;
    case CardTypes.PLUS2:
      return 4;
    case CardTypes.REVERSE:
      return 3;
    case CardTypes.BLOCK:
      return 2;
    case CardTypes.SIMPLE:
      return 1;
  }
  return -1;
}

int getColorPriority(Color color) {
  if (CardColors.COLOR1 == color) return 1;
  if (CardColors.COLOR2 == color) return 2;
  if (CardColors.COLOR3 == color) return 3;
  if (CardColors.COLOR4 == color) return 4;
  return -1;
}

int getValuePriority(String value) {
  if(value!=null)
  return int.parse(value);
  else return -1;
}

void vibrate() async {
  Vibrate.vibrateWithPauses(
      [Duration(milliseconds: 50), Duration(milliseconds: 50)]);
}

bool isValidMove(
    UNOcardData data, UNOcard cardOnTop, SinglePlayerGameState gameState) {
  print('about to throw $data , game color is ${gameState.getGameColor()}');
  switch (data.type) {
    case CardTypes.PLUS4:
    case CardTypes.WILD:
      return true;

    case CardTypes.BLOCK:
    case CardTypes.REVERSE:
    case CardTypes.PLUS2:
      if (gameState.getGameColor() == data.color)
        return true;
      else if (cardOnTop.data.type == data.type) return true;
      return false;

    case CardTypes.SIMPLE:
      if (gameState.getGameColor() == data.color)
        return true;
      else if (cardOnTop.data.type == data.type &&
          cardOnTop.data.value == data.value) return true;
      return false;
  }
  return false;
}

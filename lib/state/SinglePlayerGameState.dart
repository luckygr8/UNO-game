import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:newtest/card/functions.dart' as func;
import 'package:newtest/card/unoCard.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/ui/askColorSheet.dart';
import 'dart:ui';

import 'package:newtest/ui/logSheet.dart';
import 'package:newtest/ui/logText.dart';

class SinglePlayerGameState with ChangeNotifier {
  final Player comp = Player(2, 'BotMaster69');
  final Player you;
  final BuildContext context;
  final numberOfCards;

  Color _gameColor;
  List<UNOcard> playingCards = List<UNOcard>();
  List<UNOcard> onGoingCards = List<UNOcard>();

  List<LogText> logs = List<LogText>();

  SinglePlayerGameState(this.you, this.numberOfCards, this.context) {
    // make the deck and shuffle it thoroughly
    _makeDeck();
    _shuffleDeck();

    logs.add(LogText(
      intro: 'THE GAME STARTED',
    ));

    // give cards to both players
    giveCardsToPlayer(you, numberOfCards);
    giveCardsToPlayer(comp, numberOfCards);

    // you have the first turn
    you.hasTurn = true;

    // we try here to put a SIMPLE card on the top of the stack
    while (true) {
      int index = Random().nextInt(playingCards.length);
      if (playingCards[index].data.type == CardTypes.SIMPLE) {
        UNOcard card = playingCards.removeAt(index);
        onGoingCards.add(card);
        setTopOfTheStackCard(card);
        break;
      }
    }
  }

  void setTopOfTheStackCard(UNOcard card) {
    onGoingCards.add(card);
    _setColor(card.data.color);
    notifyListeners();
  }

  void _setColor(Color color) {
    if (!(color == null) && !(color == _gameColor))
      logs.add(LogText(
        action: 'COLOR WAS CHANGED',
        cardColor: color,
      ));
    _gameColor = color;
    notifyListeners();
  }

  Color getGameColor() => _gameColor;

  void giveCardsToPlayer(Player player, int howMuch) {
    for (int i = 0; i < howMuch; i++) {
      player.ownList.add(playingCards.removeLast());
      //Music.playRegular();
    }

    notifyListeners();
  }

  void askForColor(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ColorAskingModalSheet(_setColor),
      isDismissible: false,
    );
  }

  void showLog(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => LogSheet(this.logs),
      isDismissible: true,
    );
  }

  Player currentPlayer() => you.hasTurn ? you : comp;

  UNOcard removeCardFromPlayer(Player player, UNOcardData data) {
    for (int i = 0; i < player.ownList.length; i++)
      if (player.ownList[i].data == data) return player.ownList.removeAt(i);
    return null;
  }

  void nextTurn() async{
    you.hasTurn = !you.hasTurn;
    comp.hasTurn = !comp.hasTurn;

    if(comp.hasTurn)
    {
      await Future<void>(_singlePlayerCompTurn);
      await Future.delayed(Duration(seconds: 1));
    }

    notifyListeners();
  }

  void sortDeck(Player p) {
    p.ownList.sort((card2, card1) {
      int p1 = func.getTypePriority(card1.data.type);
      int p2 = func.getTypePriority(card2.data.type);

      if (p1 > p2)
        return 1;
      else if (p2 > p1)
        return -1;
      else {
        p1 = func.getColorPriority(card1.data.color);
        p2 = func.getColorPriority(card2.data.color);

        if (p1 > p2)
          return 1;
        else if (p2 > p1)
          return -1;
        else {
          p1 = func.getValuePriority(card1.data.value);
          p2 = func.getValuePriority(card2.data.value);

          if (p1 > p2) return 1;
          return -1;
        }
      }
    });
    notifyListeners();
  }

  void _singlePlayerCompTurn() {

    sortDeck(comp);
    UNOcard thrownCard;

    if (you.ownList.length > 5) {
      // go easy
      for (int i = comp.ownList.length - 1; i > -1; i--) {
        // reading the list from behind
        if (func.isValidMove(comp.ownList[i].data, onGoingCards.last, this)) {
          thrownCard = comp.ownList[i];
          break;
        }
      }
    } else { // go hard , reading list from front for throwing card
      for (UNOcard card in comp.ownList) // reading the list from behind
        if (func.isValidMove(card.data, onGoingCards.last, this)) {
          thrownCard = card;
          break;
        }
    }

    if(thrownCard==null){
      giveCardsToPlayer(comp, 1);
      logs.add(LogText(name: comp.name,action: 'picked a card',),);
      //if(func.isValidMove(comp.ownList.last.data, current, this))
      nextTurn();
      return;
    }

    setTopOfTheStackCard(removeCardFromPlayer(comp, thrownCard.data));
    switch (thrownCard.data.type) {
      case CardTypes.PLUS4:
        logs.add(LogText(
          name: currentPlayer().name,
          action: 'played',
          card: thrownCard.data.type.toUpperCase(),
        ));
        nextTurn();
        giveCardsToPlayer(you, 4);
        _setColor(_getHighestColor(comp.ownList));
        break;
      case CardTypes.WILD:
        logs.add(LogText(
          name: currentPlayer().name,
          action: 'played',
          card: thrownCard.data.type.toUpperCase(),
        ));
        nextTurn();
        _setColor(_getHighestColor(comp.ownList));
        break;
      case CardTypes.PLUS2:
        logs.add(LogText(
          name: currentPlayer().name,
          action: 'played',
          card: thrownCard.data.type.toUpperCase(),
          valueColor: thrownCard.data.color,
        ));
        nextTurn();
        giveCardsToPlayer(you, 2);
        break;
      case CardTypes.BLOCK:
      case CardTypes.REVERSE:
        logs.add(LogText(
          name: currentPlayer().name,
          action: 'played',
          card: thrownCard.data.type.toUpperCase(),
          valueColor: thrownCard.data.color,
        ));
        _singlePlayerCompTurn();
        break;
      case CardTypes.SIMPLE:
        logs.add(LogText(
          name: currentPlayer().name,
          action: 'played',
          card: '${thrownCard.data.value} of ${thrownCard.data.type.toUpperCase()}',
          valueColor: thrownCard.data.color,
        ));
        nextTurn();
        break;
    }
  }

  Color _getHighestColor(List<UNOcard> list) {
    var map = {
      CardColors.COLOR1: 0,
      CardColors.COLOR2: 0,
      CardColors.COLOR3: 0,
      CardColors.COLOR4: 0,
    };

    for (UNOcard card in list)
      if (!(card.data.type == CardTypes.PLUS4 ||
          card.data.type == CardTypes.WILD)) map[card.data.color]++;

    Color greatest = CardColors.COLOR1;

    for (Color key in map.keys) if (map[key] > map[greatest]) greatest = key;

    return greatest;
  }

  void _shuffleDeck() {
    for (int i = 0; i < 500; i++) {
      int i = Random().nextInt(107);
      int j = Random().nextInt(107);
      UNOcard temp = playingCards[i];
      playingCards[i] = playingCards[j];
      playingCards[j] = temp;
    }
  }

  _makeDeck() {
    // adds 19 COLOR1 cards
    for (int i = 0; i < 10; i++)
      if (i == 0)
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR1, value: "$i")));
      else {
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR1, value: "$i")));
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR1, value: "$i")));
      }
    for (int i = 0; i < 2; i++) {
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.BLOCK, color: CardColors.COLOR1)));
      playingCards.add(
          UNOcard(UNOcardData(CardTypes.REVERSE, color: CardColors.COLOR1)));
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.PLUS2, color: CardColors.COLOR1)));
    }
    playingCards.add(UNOcard(UNOcardData(CardTypes.WILD)));
    playingCards.add(UNOcard(UNOcardData(CardTypes.PLUS4)));

    // adds 19 COLOR2 cards
    for (int i = 0; i < 10; i++)
      if (i == 0)
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR2, value: "$i")));
      else {
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR2, value: "$i")));
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR2, value: "$i")));
      }
    for (int i = 0; i < 2; i++) {
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.BLOCK, color: CardColors.COLOR2)));
      playingCards.add(
          UNOcard(UNOcardData(CardTypes.REVERSE, color: CardColors.COLOR2)));
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.PLUS2, color: CardColors.COLOR2)));
    }
    playingCards.add(UNOcard(UNOcardData(CardTypes.WILD)));
    playingCards.add(UNOcard(UNOcardData(CardTypes.PLUS4)));

    // adds 19 COLOR3 cards
    for (int i = 0; i < 10; i++)
      if (i == 0)
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR3, value: "$i")));
      else {
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR3, value: "$i")));
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR3, value: "$i")));
      }
    for (int i = 0; i < 2; i++) {
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.BLOCK, color: CardColors.COLOR3)));
      playingCards.add(
          UNOcard(UNOcardData(CardTypes.REVERSE, color: CardColors.COLOR3)));
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.PLUS2, color: CardColors.COLOR3)));
    }
    playingCards.add(UNOcard(UNOcardData(CardTypes.WILD)));
    playingCards.add(UNOcard(UNOcardData(CardTypes.PLUS4)));

    // adds 19 COLOR4 cards
    for (int i = 0; i < 10; i++)
      if (i == 0)
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR4, value: "$i")));
      else {
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR4, value: "$i")));
        playingCards.add(UNOcard(UNOcardData(CardTypes.SIMPLE,
            color: CardColors.COLOR4, value: "$i")));
      }

    for (int i = 0; i < 2; i++) {
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.BLOCK, color: CardColors.COLOR4)));
      playingCards.add(
          UNOcard(UNOcardData(CardTypes.REVERSE, color: CardColors.COLOR4)));
      playingCards
          .add(UNOcard(UNOcardData(CardTypes.PLUS2, color: CardColors.COLOR4)));
    }
    playingCards.add(UNOcard(UNOcardData(CardTypes.WILD)));
    playingCards.add(UNOcard(UNOcardData(CardTypes.PLUS4)));
  }
}

/**
 * when bot plays block or rev , its stuck
 * when we pick card or throw wild / 4plus , turn should change
 */
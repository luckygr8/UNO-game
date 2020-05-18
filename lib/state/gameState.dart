import 'package:flutter/material.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/card/card.dart';
import 'package:newtest/card/cardConst.dart';
import 'dart:math';
import 'package:newtest/card/functions.dart';
import 'package:newtest/ui/askColorSheet.dart';
import 'package:newtest/ui/onGameEndSheet.dart';

class GameState with ChangeNotifier {
  List<Player> gcurrentPlayers = [];
  List<Widget> gplayingCards = [];
  List<Widget> gonGoingCards = [];
  final int gnumberOfCards;
  final Player gyou;
  Player gcomp = Player(2, '_not_bot_69');
  Color ggameColor;
  BuildContext context;
  // WILL BUILD SOME TIME LATER ON IN LIFE
  /*GameState.multiPlayer(List<Player> players) {
    for (Player p in players) {
      currentPlayers.add(p);
      currentTurns.add(false);
    }
  }*/

  GameState.singlePlayer(this.gyou, this.gnumberOfCards,this.context) {
    _makeDeck();

    gcurrentPlayers.add(gyou);
    gcurrentPlayers.add(gcomp);

    gyou.hasTurn = true;

    _shuffleDeck();
    _startGame();
  }

  void _startGame() {
    // setting players with cards
    for (Player p in gcurrentPlayers)
      for (int i = 0; i < gnumberOfCards; i++)
        p.ownList.add(gplayingCards.removeLast());

    /*for(Player p in currentPlayers)
      _printPlayer(p);*/

    // setting a card on the top of ongoing card deck
    while (true) {
      int index = Random().nextInt(gplayingCards.length);
      if (ftypeOfCard(gplayingCards[index]) == 1) {
        addIntoOnGoingCards(gplayingCards.removeAt(index));
        break;
      }
    }
    notifyListeners();
  }

  void addIntoOnGoingCards(Widget card) {
    /*if(ftypeOfCard(card)<5)
      ggameColor = (card as RegularUnoCard).color;
    else
      shouldAskForColor = true;*/
    gonGoingCards.add(card);
    gsetGameColor((card as RegularUnoCard).color);
    notifyListeners();
  }

  Player ggetPlayerWithCurrentTurn() {
    for (int i = 0; i < gcurrentPlayers.length; i++)
      if (gcurrentPlayers[i].hasTurn) return gcurrentPlayers[i];
    return null;
  }

  void gsetGameColor(Color color) {
    this.ggameColor = color;
    notifyListeners();
  }

  void gaskForColor(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) => ColorAskingModalSheet(gsetGameColor),
      isDismissible: false,
    );
  }

  void showWinningDialog(String nameOfWinner){
    showDialog(builder:(context) => OnGameEndSheet(nameOfWinner) ,context: context);
  }

  bool checkIfSomeOneHasWon(){
    if(gyou.ownList.isEmpty){
      showWinningDialog(gyou.name);
      return true;
    }
    if(gcomp.ownList.isEmpty){
      showWinningDialog(gcomp.name);
      return true;
    }
    return false;
  }

  void gnextTurn() {
    /*for(int i=0;i<gcurrentPlayers.length;i++)
      if(gcurrentPlayers[i].hasTurn){
        gcurrentPlayers[i].hasTurn = false;
        if (i == gcurrentPlayers.length - 1)
          gcurrentPlayers[0].hasTurn = true;
        else
          gcurrentPlayers[i + 1].hasTurn = true;
        break;
      }*/
    if(!checkIfSomeOneHasWon())
    if (gyou.hasTurn) {
      gyou.hasTurn = false;
      gcomp.hasTurn = true;
    } else {
      gyou.hasTurn = true;
      gcomp.hasTurn = false;
    }
    notifyListeners();
  }

  void ggiveCardToCurrentPlayer(int howMuch) {
    for (int i = 0; i < howMuch; i++)
      ggetPlayerWithCurrentTurn().ownList.add(gplayingCards.removeLast());
    notifyListeners();
  }
  void gRemoveCardFromCurrentPlayer(CardData whichCardTho) {
    for (int i = 0; i < ggetPlayerWithCurrentTurn().ownList.length; i++)
      switch(ftypeOfCard(ggetPlayerWithCurrentTurn().ownList[i])){
        case 1:
        case 2:
        case 3:
        case 4:
          if((ggetPlayerWithCurrentTurn().ownList[i] as RegularUnoCard).value==whichCardTho.value && (ggetPlayerWithCurrentTurn().ownList[i] as RegularUnoCard).color==whichCardTho.color){
            gonGoingCards.add(ggetPlayerWithCurrentTurn().ownList.removeAt(i));
            ggameColor=whichCardTho.color;
          }break;
        case 5:
        case 6:
        if((ggetPlayerWithCurrentTurn().ownList[i] as SpecialUnoCard).value==whichCardTho.value){
          gonGoingCards.add(ggetPlayerWithCurrentTurn().ownList.removeAt(i));
          ggameColor=whichCardTho.color;
        }break;
      }
    notifyListeners();
  }

  void gsort() {}

  /*
 * utility functions for filling the game cards and providing testing stuff. nothing special
 */

  void _printPlayer(Player p) {
    print("player :: name - ${p.name} id - ${p.id} turn - ${p.hasTurn}");
    for (int i = 0; i < gnumberOfCards; i++) {
      dynamic card = p.ownList[i];
      if (card is RegularUnoCard)
        print((card).log());
      else if (card is SpecialUnoCard) print((card).log());
    }
  }

  int key = 1;
  void _makeDeck() {
    _addSpecials();
    for (var i in [blue, green, red, orange]) {
      _addNumbers(i);
      _addOthers(i);
    }
  }

  void _shuffleDeck() {
    for (int i = 0; i < 200; i++) {
      int i = Random().nextInt(108);
      int j = Random().nextInt(108);
      Widget temp = gplayingCards[i];
      gplayingCards[i] = gplayingCards[j];
      gplayingCards[j] = temp;
    }
  }

  void _addNumbers(Color color) {
    for (var i = 0; i <= 9; i++) {
      if (i == 0)
        gplayingCards.add(RegularUnoCard(color, "$i"));
      else {
        gplayingCards.add(RegularUnoCard(color, "$i"));
        gplayingCards.add(RegularUnoCard(color, "$i"));
      }
    }
  }

  void _addOthers(Color color) {
    gplayingCards.add(RegularUnoCard(color, plus2));
    gplayingCards.add(RegularUnoCard(color, plus2));
    gplayingCards.add(RegularUnoCard(color, block));
    gplayingCards.add(RegularUnoCard(color, block));
    gplayingCards.add(RegularUnoCard(color, reverse));
    gplayingCards.add(RegularUnoCard(color, reverse));
  }

  void _addSpecials() {
    for (var i = 0; i < 4; i++) {
      gplayingCards.add(SpecialUnoCard(plus4));
      gplayingCards.add(SpecialUnoCard(wild));
    }
  }
}

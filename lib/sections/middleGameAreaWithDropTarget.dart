import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newtest/card/functions.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:newtest/model/dimens.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';
import 'package:newtest/ui/logText.dart';
import 'package:provider/provider.dart';

class MiddleGameAreaWithDropTarget extends StatefulWidget {
  @override
  _MiddleGameAreaWithDropTargetState createState() =>
      _MiddleGameAreaWithDropTargetState();
}

class _MiddleGameAreaWithDropTargetState
    extends State<MiddleGameAreaWithDropTarget> {
      
  void performAction(UNOcardData data, SinglePlayerGameState gameState) {
    try{
    gameState.setTopOfTheStackCard(
        gameState.removeCardFromPlayer(gameState.you, data));
    switch (data.type) {
      case CardTypes.PLUS4:
        //print("${CardTypes.PLUS4} was thrown");
        gameState.logs.add(LogText(name: gameState.currentPlayer().name,action: 'played',card: data.type.toUpperCase(),));
        //gameState.nextTurn();
        gameState.giveCardsToPlayer(gameState.comp, 4);
        gameState.askForColor(context);
        break;
      case CardTypes.WILD:
        //print("${CardTypes.WILD} was thrown");
        gameState.logs.add(LogText(name: gameState.currentPlayer().name,action: 'played',card: data.type.toUpperCase(),));
        //gameState.nextTurn();
        gameState.askForColor(context);
        break;
      case CardTypes.PLUS2:
        //print("${CardTypes.PLUS2} was thrown");
        gameState.logs.add(LogText(name: gameState.currentPlayer().name,action: 'played',card: data.type.toUpperCase(),valueColor: data.color,));
        gameState.nextTurn();
        gameState.giveCardsToPlayer(gameState.comp, 2);
        break;
      case CardTypes.BLOCK:
      case CardTypes.REVERSE:
        /*print(
            "${CardTypes.BLOCK} was thrown or ${CardTypes.REVERSE} was thrown");*/
            gameState.logs.add(LogText(name: gameState.currentPlayer().name,action: 'played',card: data.type.toUpperCase(),valueColor: data.color,));
        break;
      case CardTypes.SIMPLE:
        //print("${CardTypes.SIMPLE} was thrown");
        gameState.logs.add(LogText(name: gameState.currentPlayer().name,action: 'played',card:'${data.value} of ${data.type.toUpperCase()}',valueColor: data.color,));
        gameState.nextTurn();
        break;
    }}catch(e){
      print('found issue');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<SinglePlayerGameState>(
      builder: (context, gameState, child) => Expanded(
        flex: 48,
        child: Container(
          color: gameState.getGameColor(),
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Align(
                  child:Transform.rotate(
                    angle: 45,
                    child: UNOcard(UNOcardData(CardTypes.BACK)),
                  ),
                  alignment: Alignment(0,-1.3),
                ),
                Align(
                  child: Transform.rotate(
                    angle: 65,
                    child: UNOcard(UNOcardData(CardTypes.BACK)),
                  ),
                  alignment: Alignment(-1,0),
                ),
                Align(
                  child: Transform.rotate(
                    angle: 180,
                    child: UNOcard(UNOcardData(CardTypes.BACK)),
                  ),
                  alignment: Alignment(-.30,1.5),
                ),
                Align(
                  child: Transform.rotate(
                    angle: 45,
                    child: UNOcard(UNOcardData(CardTypes.BACK)),
                  ),
                  alignment: Alignment(1,0),
                ),
                Align(
                  child: Transform.rotate(
                    angle: 65,
                    child: UNOcard(UNOcardData(CardTypes.BACK)),
                  ),
                  alignment: Alignment(.8,1.4),
                ),
                /*Align(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black),
                    child: Text(
                      "${gameState.playingCards.length}",
                      style: TextStyle(
                          fontSize: Dimens.width/5,
                          fontFamily: 'Frijole',
                          color: Colors.white),
                    ),
                    padding: EdgeInsets.all(7),
                  ),
                  alignment: Alignment(1,0),
                ),*/
                Positioned(
                  child: SizedBox(
                    child: Center(
                        child: FlatButton(
                      onPressed: () {
                        gameState.nextTurn();
                      },
                      child: Icon(
                        FontAwesomeIcons.undoAlt,
                        size: 25,
                      ),
                      color: Colors.white,
                    )),
                    height: 35,
                    width: 60,
                  ),
                  bottom: 10,
                  left: 10,
                ),
                Align(
                  child: DragTarget<UNOcardData>(
                    onWillAccept: (UNOcardData data) {
                      var res = isValidMove(
                          data, gameState.onGoingCards.last, gameState);
                      if(res){
                        print(res);
                        return true;
                      }else{
                        vibrate();
                         return false;
                      }
                    },
                    onAccept: (UNOcardData data) {
                      print(data);
                      performAction(data, gameState);
                    },
                    builder: (context, candidateData, rejectedData) =>
                        Transform.rotate(
                      angle: 0,
                      child: gameState.onGoingCards.last,
                    ),
                  ),
                  alignment: Alignment(0,0),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

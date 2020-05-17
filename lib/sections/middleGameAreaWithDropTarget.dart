import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newtest/card/cardConst.dart';
import 'package:provider/provider.dart';
import 'package:newtest/state/gameState.dart';
import 'package:newtest/card/card.dart';
import 'package:newtest/model/player.dart';

class MiddleGameAreaWithDropTarget extends StatefulWidget {
  @override
  _MiddleGameAreaWithDropTargetState createState() =>
      _MiddleGameAreaWithDropTargetState();
}

class _MiddleGameAreaWithDropTargetState
    extends State<MiddleGameAreaWithDropTarget> {

  bool isValidMove(CardData data, Widget cardOnTop, GameState gameState) {
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

  void performAction(CardData data , GameState gameState){
    //gameState.gnextTurn();
    if(data.value==plus4){
      gameState.ggiveCardToCurrentPlayer(4);
      gameState.gaskForColor(context);
    }else if(data.value==wild){
      gameState.gaskForColor(context);
    }else if(data.value==block){

    }
    else if(data.value==reverse){
      
    }
    else if(data.value==plus2){
      
    }
    else{
      
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) => Expanded(
        flex: 42,
        child: Container(
          color: gameState.ggameColor,
          child: Center(
            child: Stack(
              overflow: Overflow.visible,
              children: <Widget>[
                Positioned(
                  child: Transform.rotate(
                    angle: 45,
                    child: BackFacedUnoCard(),
                  ),
                  top: -30,
                  left: 90,
                ),
                Positioned(
                  child: Transform.rotate(
                    angle: 65,
                    child: BackFacedUnoCard(),
                  ),
                  top: 20,
                  left: 50,
                ),
                Positioned(
                  child: Transform.rotate(
                    angle: 180,
                    child: BackFacedUnoCard(),
                  ),
                  top: 100,
                  left: 65,
                ),
                Positioned(
                  child: Transform.rotate(
                    angle: 45,
                    child: BackFacedUnoCard(),
                  ),
                  top: 10,
                  right: 10,
                ),
                Positioned(
                  child: Transform.rotate(
                    angle: 65,
                    child: BackFacedUnoCard(),
                  ),
                  top: 120,
                  right: 50,
                ),
                Positioned(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        color: Colors.black),
                    child: Text(
                      "${gameState.gplayingCards.length}",
                      style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Frijole',
                          color: Colors.white),
                    ),
                    padding: EdgeInsets.all(7),
                  ),
                  top: 10,
                  left: 10,
                ),
                Positioned(
                  child: SizedBox(
                    child: Center(
                        child: FlatButton(
                      onPressed: () {
                        gameState.gnextTurn();
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
                Positioned(
                  child: DragTarget<CardData>(
                    onWillAccept: (CardData data) {
                      bool res = isValidMove(
                          data, gameState.gonGoingCards.last, gameState);
                      print(res);
                      return res;
                    },
                    onAccept: (CardData data) {
                      print(data);
                      performAction(data,gameState);
                    },
                    builder: (context, candidateData, rejectedData) =>
                        Transform.rotate(
                      angle: 0,
                      child: gameState.gonGoingCards.last,
                    ),
                  ),
                  top: 60,
                  right: 100,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

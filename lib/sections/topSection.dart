import 'package:flutter/material.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';
import 'package:provider/provider.dart';

class TopSection extends StatefulWidget {
  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<SinglePlayerGameState>(
      builder: (context, gameState, child) => Expanded(
        flex: 8,
        child: Container(
          color: gameState.getGameColor(),
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: Container(
                  padding: EdgeInsets.all(5),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(20),
                      bottomRight: Radius.circular(20),
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '${gameState.currentPlayer().name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Fredricka',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              /*Expanded(
                flex: 1,
                child: Button(
                  () {},
                  Text('S'),
                    gameState.getGameColor()
                ),
              ),*/
              Expanded(
                flex: 1,
                child: Text(
                  "bot:${gameState.comp.ownList.length}",
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

import 'dart:ui';

import 'package:audioplayers/audio_cache.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newtest/card/music.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';
import 'package:newtest/ui/logText.dart';
import 'package:newtest/ui/roundButton.dart';
import 'package:provider/provider.dart';

class AccessiblityPanel extends StatefulWidget {
  @override
  _AccessiblityPanelState createState() => _AccessiblityPanelState();
}

class _AccessiblityPanelState extends State<AccessiblityPanel> {

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
                flex: 1,
                child: Button(
                  gameState.you.hasTurn ?() {
                  gameState.giveCardsToPlayer(gameState.you, 1);
                  gameState.logs.add(LogText(name: "${gameState.you.name}",action: 'picked a card',));
                  }:null,
                  Icon(FontAwesomeIcons.handPointDown,size: window.physicalSize.width/50,),
                  gameState.getGameColor()
                ),
              ),
              Expanded(
                flex: 2,
                child: Button(
                  gameState.you.hasTurn ? () {
                    gameState.showLog(context);
                    //Music.playLogs();
                    
                  }:null,
                  Text('LOGS',style: TextStyle(fontFamily: 'Fredricka',fontSize:  window.physicalSize.width/60,fontWeight: FontWeight.bold),),
                   gameState.getGameColor()
                ),
              ),
              Expanded(
                flex: 1,
                child: Button(
                  gameState.you.hasTurn ? () {
                    gameState.sortDeck(gameState.you);
                  }:null,
                  Text('S'),
                    gameState.getGameColor()
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    '${gameState.you.name} : ${gameState.you.ownList.length}',
                    style:
                        TextStyle(fontSize: 16, fontWeight: FontWeight.bold,),textAlign: TextAlign.center,),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/*
https://youtu.be/T5o_0BoTvWg
* */
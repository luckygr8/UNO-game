import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:newtest/ui/roundButton.dart';
import 'package:provider/provider.dart';
import 'package:newtest/state/gameState.dart';

class AccessiblityPanel extends StatefulWidget {
  @override
  _AccessiblityPanelState createState() => _AccessiblityPanelState();
}

class _AccessiblityPanelState extends State<AccessiblityPanel> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) => Expanded(
        flex: 8,
        child: Container(
          color: Colors.grey,
          child: Row(
            children: <Widget>[
              Expanded(
                flex: 1,
                child: Button(
                  /*(gameState.ggetPlayerWithCurrentTurn()==gameState.gyou)? */() {
                  gameState.ggiveCardToPlayer(1,gameState.gyou);
                  }/*:null*/,
                  Icon(FontAwesomeIcons.handPointDown,size: 30,),
                ),
              ),
              Expanded(
                flex: 2,
                child: Button(
                  (gameState.ggetPlayerWithCurrentTurn()==gameState.gyou)? () {
                    
                  }:null,
                  Text('UNO!!!',style: TextStyle(fontFamily: 'Fredricka',fontSize: 20,fontWeight: FontWeight.bold),),
                ),
              ),
              Expanded(
                flex: 1,
                child: Button(
                  (gameState.ggetPlayerWithCurrentTurn()==gameState.gyou)? () {
                    
                  }:null,
                  Text('S'),
                ),
              ),
              Expanded(
                flex: 2,
                child: Text(
                    '${gameState.gyou.name} : ${gameState.gyou.ownList.length}',
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
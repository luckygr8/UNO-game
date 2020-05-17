import 'package:flutter/material.dart';
import 'package:newtest/card/card.dart';
import 'package:provider/provider.dart';
import 'package:newtest/state/gameState.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/ui/roundButton.dart';

import 'package:newtest/sections/middleGameAreaWithDropTarget.dart';
import 'package:newtest/sections/topSection.dart';
import 'package:newtest/sections/accessibilityPanel.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState.singlePlayer(Player(1, 'LUCKY'), 10),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TopSection(),
              Expanded(
                flex: 8,
                child: Container(
                  color: Colors.blue,
                ),
              ),
              MiddleGameAreaWithDropTarget(),
              AccessiblityPanel(),
              LowerSectionWithScrollingCardList(),
            ],
          ),
        ),
      ),
    );
  }
}

class LowerSectionWithScrollingCardList extends StatefulWidget {
  @override
  _LowerSectionWithScrollingCardListState createState() =>
      _LowerSectionWithScrollingCardListState();
}

class _LowerSectionWithScrollingCardListState
    extends State<LowerSectionWithScrollingCardList> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) {
//        print('lower list ${gameState.gcurrentPlayers[0].ownList}');
        return Expanded(
          flex: 34,
          child: Container(
            color: Colors.white,
            child: ListView(
              children: List<Widget>.from(gameState.gcurrentPlayers[0].ownList),
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
      key: UniqueKey(),
    );
  }
}

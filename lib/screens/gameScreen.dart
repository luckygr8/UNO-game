import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:provider/provider.dart';
import 'package:newtest/state/gameState.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/ui/onGameEndSheet.dart';

import 'package:newtest/sections/middleGameAreaWithDropTarget.dart';
import 'package:newtest/sections/topSection.dart';
import 'package:newtest/sections/accessibilityPanel.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => GameState.singlePlayer(Player(1, 'LUCKY'), 10,context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TopSection(),
              LogSection(),
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

class LogSection extends StatefulWidget {
  @override
  _LogSectionState createState() => _LogSectionState();
}

class _LogSectionState extends State<LogSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) => Expanded(
        flex: 8,
        child: Container(
          color: gameState.ggameColor,
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

//class _LowerSectionWithScrollingCardListState
//    extends State<LowerSectionWithScrollingCardList> {
//  @override
//  Widget build(BuildContext context) {
//    return Consumer<GameState>(
//      builder: (context, gameState, child) {
////        print('lower list ${gameState.gcurrentPlayers[0].ownList}');
//        return Expanded(
//          flex: 34,
//          child: Container(
//            color: Colors.white,
//            child: ListView(
//              children: List<Widget>.from(gameState.gcurrentPlayers[0].ownList),
//              scrollDirection: Axis.horizontal,
//            ),
//          ),
//        );
//      },
//      key: UniqueKey(),
//    );
//  }
//}

class _LowerSectionWithScrollingCardListState
    extends State<LowerSectionWithScrollingCardList> {

  List<UNOcard> list = [
    UNOcard(UNOcardData(CardTypes.PLUS4)),
  ];

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
              children: list,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
      key: UniqueKey(),
    );
  }
}

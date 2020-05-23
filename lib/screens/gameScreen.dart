import 'package:flutter/material.dart';
import 'package:newtest/sections/lowerSectionWithScrollingCardList.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';
import 'package:provider/provider.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/sections/middleGameAreaWithDropTarget.dart';
import 'package:newtest/sections/topSection.dart';
import 'package:newtest/sections/accessibilityPanel.dart';

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => SinglePlayerGameState(Player(1, 'LUCKY'), 10,context),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            children: <Widget>[
              TopSection(),
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




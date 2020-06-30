import 'package:flutter/material.dart';
import 'package:newtest/model/dimens.dart';
import 'package:newtest/sections/lowerSectionWithScrollingCardList.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';
import 'package:provider/provider.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/sections/middleGameAreaWithDropTarget.dart';
import 'package:newtest/sections/topSection.dart';
import 'package:newtest/sections/accessibilityPanel.dart';

class GameScreen extends StatelessWidget {

  final Player p1;
  final int numberOfCards;

  GameScreen(this.p1,this.numberOfCards);

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    Dimens.ppi = MediaQuery.of(context).devicePixelRatio;
    Dimens.height = size.height;
    Dimens.width = size.width;

    return ChangeNotifierProvider(
      create: (context) => SinglePlayerGameState(p1, numberOfCards,context),
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




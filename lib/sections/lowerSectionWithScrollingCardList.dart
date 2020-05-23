import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:newtest/state/SinglePlayerGameState.dart';
import 'package:provider/provider.dart';

class LowerSectionWithScrollingCardList extends StatefulWidget {
  @override
  _LowerSectionWithScrollingCardListState createState() =>
      _LowerSectionWithScrollingCardListState();
}

class _LowerSectionWithScrollingCardListState
    extends State<LowerSectionWithScrollingCardList> {

  @override
  Widget build(BuildContext context) {
    return Consumer<SinglePlayerGameState>(
      builder: (context, gameState, child) {
        return Expanded(
          flex: 36,
          child: Container(
            color: Colors.white,
            child: ListView(
              children: List<UNOcard>.from(gameState.you.ownList),
              addAutomaticKeepAlives: true,
              cacheExtent: 108,
              scrollDirection: Axis.horizontal,
            ),
          ),
        );
      },
    );
  }
}

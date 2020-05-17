import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:newtest/state/gameState.dart';
import 'package:newtest/ui/roundButton.dart';

class TopSection extends StatefulWidget {
  @override
  _TopSectionState createState() => _TopSectionState();
}

class _TopSectionState extends State<TopSection> {
  @override
  Widget build(BuildContext context) {
    return Consumer<GameState>(
      builder: (context, gameState, child) => Expanded(
        flex: 8,
        child: Container(
          color: Colors.red,
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
                      '${gameState.ggetPlayerWithCurrentTurn().name}',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 30,
                          fontFamily: 'Fredricka',
                          fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Button(
                  () {},
                  Text('S'),
                ),
              ),
              Expanded(
                flex: 1,
                child: Text(
                  "${gameState.gcomp.ownList.length}",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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

import 'package:flutter/material.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/screens/gameScreen.dart';
import 'package:newtest/screens/introScreen.dart';


void main() {
  runApp(UnoApp());
}

class UnoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/game': (_) => GameScreen(Player(1, 'lucky'), 10),
        '/intro':(_)=>IntroScreen(),
      },
      initialRoute: '/intro',
    );
  }
}


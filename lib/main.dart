import 'package:flutter/material.dart';
import 'screens/introScreen.dart';
import 'screens/gameScreen.dart';

void main() {
  runApp(UnoApp());
}

class UnoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        '/intro':(_)=> IntroScreen(),
        '/game':(_)=> GameScreen(),
      },
      initialRoute: '/intro',
    );
  }
}
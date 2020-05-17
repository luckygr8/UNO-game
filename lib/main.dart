import 'package:flutter/material.dart';
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
        '/intro':(_)=> Container(),
        '/options':(_)=> Container(),
        '/game':(_)=> GameScreen(),
      },
      initialRoute: '/game',
    );
  }
}
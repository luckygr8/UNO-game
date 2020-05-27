import 'dart:ui';

import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/screens/gameScreen.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';

class IntroScreen extends StatefulWidget {
  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 12));
    _animation = RainbowColorTween([
      CardColors.COLOR1,
      CardColors.COLOR2,
      CardColors.COLOR3,
      CardColors.COLOR4,
      CardColors.COLOR1,
    ]).chain(CurveTween(curve: Curves.easeInOut)).animate(_controller);
    _controller.addListener(() {
      setState(() {});
    });
    _controller.repeat();
    super.initState();
  }

  @override
  void deactivate() {
    _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: ChangeNotifierProvider<_DataModel>(
          create: (context) => _DataModel(),
          child: Container(
            color: _animation.value,
            child: Column(
              children: <Widget>[
                Spacer(
                  flex: 10,
                ),
                Expanded(
                  flex: 30,
                  child: Container(
                    child: FlareActor(
                      "assets/intro_anim.flr",
                      alignment: Alignment.center,
                      fit: BoxFit.fill,
                      animation: 'intro',
                    ),
                  ),
                ),
                Expanded(
                  flex: 40,
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 25,
                          child: _SelectCards(),
                        ),
                        Expanded(
                          flex: 45,
                          child: _TextField(),
                        ),
                        Expanded(
                          flex: 30,
                          child: _Play(),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 20,
                  child: Container(
                      child: FlareActor(
                    "assets/slowcards.flr",
                    alignment: Alignment.center,
                    fit: BoxFit.fill,
                    animation: 'anim1',
                  )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _TextField extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double ppi = MediaQuery.of(context).devicePixelRatio;
    return Consumer<_DataModel>(
      builder: (context, model, child) => Container(
        padding: EdgeInsets.all(110 / ppi),
        child: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(70 / ppi),
            boxShadow: [
              BoxShadow(color: Colors.grey, blurRadius: 4, spreadRadius: 1)
            ],
          ),
          child: TextFormField(
            onChanged: (value) => model.name = value,
            decoration: InputDecoration(
              hintText: 'Please enter your name',
              border: InputBorder.none,
              hintStyle: TextStyle(color: Colors.grey, fontSize: 70 / ppi),
            ),
            textAlign: TextAlign.center,
            style: TextStyle(
                fontFamily: 'Fredericka',
                fontSize: 85 / ppi,
                color: Colors.black),
          ),
        ),
      ),
    );
  }
}

class _SelectCards extends StatefulWidget {
  @override
  __SelectCardsState createState() => __SelectCardsState();
}

class __SelectCardsState extends State<_SelectCards> {
  double _value = 10;
  @override
  Widget build(BuildContext context) {
    return Consumer<_DataModel>(
      builder: (context, value, child) => Container(
        child: Slider(
            value: _value,
            min: 5,
            max: 15,
            label: 'SELECT THE NUMBER OF CARDS',
            activeColor: Colors.white,
            inactiveColor: Colors.black,
            onChanged: (newval) {
              setState(() {
                _value = newval;
                value.setNumberOfCards(newval.toInt());
              });
            }),
      ),
    );
  }
}

class _Play extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double ppi = MediaQuery.of(context).devicePixelRatio;
    return Consumer<_DataModel>(
      builder: (context, value, child) => Container(
        padding: EdgeInsets.all(55 / ppi),
        child: FlatButton(
          color: Colors.white,
          shape: BeveledRectangleBorder(
            borderRadius: BorderRadius.circular(24 / ppi),
          ),
          onPressed: () async {
            await Future.delayed(Duration(seconds: 1));
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    GameScreen(Player(1, value.name), value.numberOfCards),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(30/ppi),
            child: Text('PLAY WITH ${value.numberOfCards} CARDS',style: TextStyle(fontSize: 50/ppi),),
          ),
        ),
      ),
    );
  }
}

class _DataModel with ChangeNotifier {
  String name = "GUEST";
  int numberOfCards = 10;

  void setName(String name) {
    this.name = name;
    notifyListeners();
  }

  void setNumberOfCards(int cards) {
    this.numberOfCards = cards;
    notifyListeners();
  }
}

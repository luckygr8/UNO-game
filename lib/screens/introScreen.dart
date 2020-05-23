import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:rainbow_color/rainbow_color.dart';

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
        AnimationController(vsync: this, duration: Duration(seconds: 4));
    _animation = RainbowColorTween([
      CardColors.COLOR1,
      CardColors.COLOR2,
      CardColors.COLOR3,
      CardColors.COLOR4,
      CardColors.COLOR1,
    ]).chain(CurveTween(curve: Curves.easeInOutCubic)).animate(_controller);
    _controller.addListener(() {
      setState(() {
        print(_animation.value);
      });
    });
    _controller.repeat();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: _animation.value,
        child: Column(
          children: <Widget>[
            _Logo(),
          ],
        ),
      ),
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: FlareActor(
        "assets/intro_anim.flr",
        alignment: Alignment.center,
        fit: BoxFit.contain,
        animation: 'intro',
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newtest/model/player.dart';
import 'dart:math';
import 'cardConst.dart';
import 'package:flutter_svg/flutter_svg.dart';

final _cardHeight = 130.00;
final _cardWidth = 100.00;
final _cardCornerRadii = 12.00;
final _cardMarginVer = 40.00;
final _cardMarginHor = 20.00;
final _cardTextStyle = TextStyle(
  fontFamily: 'Frijole',
  fontSize: 90,
  color: Colors.black,
);

class RegularUnoCard extends StatelessWidget {
  final Color color;
  final String value;
  RegularUnoCard(this.color, this.value);

  String log() {
    return '$value - ${color.toString()}';
  }

  Widget getLogo() {
    switch (value) {
      case block:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/block.svg'),
        );
      case reverse:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/reverse.svg'),
        );
      case plus2:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/plus2.svg'),
        );
      default:
        return Text(
          value,
          style: _cardTextStyle,
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Draggable<CardData>(
      data: CardData(value: value, color: color),
      feedback: this,
      childWhenDragging: BackFacedUnoCard(),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: _cardMarginVer, horizontal: _cardMarginHor),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cardCornerRadii),
          border: Border.all(color: color, width: 4, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(
                color: color,
                spreadRadius: (value == plus2) ? 8 : 2,
                blurRadius: 5)
          ],
          color: Colors.white,
        ),
        child: Container(
          height: _cardHeight,
          width: _cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(60),
            color: color,
          ),
          child: Center(
            child: getLogo(),
          ),
        ),
      ),
    );
  }
}

class SpecialUnoCard extends StatefulWidget {
  final String value;
  SpecialUnoCard(this.value);

  String log() {
    return '$value';
  }

  @override
  _SpecialUnoCardState createState() => _SpecialUnoCardState();
}

class _SpecialUnoCardState extends State<SpecialUnoCard>
    with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;
  int index = 0;

  final _listOfTweens = [
    ColorTween(begin: red, end: blue),
    ColorTween(begin: red, end: green),
    ColorTween(begin: red, end: orange),
    ColorTween(begin: blue, end: red),
    ColorTween(begin: blue, end: green),
    ColorTween(begin: blue, end: orange),
    ColorTween(begin: green, end: red),
    ColorTween(begin: green, end: blue),
    ColorTween(begin: green, end: orange),
    ColorTween(begin: orange, end: red),
    ColorTween(begin: orange, end: green),
    ColorTween(begin: orange, end: blue),
  ];

  ColorTween tween() =>
      _listOfTweens[Random().nextInt(_listOfTweens.length - 1)];

  @override
  void initState() {
    _controller =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    _animation = tween()
        .chain(CurveTween(curve: Curves.easeInOutCubic))
        .animate(_controller);

    _controller.addListener(() {
      setState(() {});
    });

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        /*_animation = tween()
            .chain(CurveTween(curve: Curves.easeInOutCirc))
            .animate(_controller);*/
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        /*_animation = tween()
            .chain(CurveTween(curve: Curves.easeInOutCirc))
            .animate(_controller);*/
        _controller.forward();
      }
    });

    _controller.forward();

    super.initState();
  }

  @override
  void deactivate() {
    _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Draggable(
      feedback: widget,
      data: CardData(value: widget.value),
      childWhenDragging: BackFacedUnoCard(),
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: _cardMarginVer, horizontal: _cardMarginHor),
        padding: EdgeInsets.all(15),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(_cardCornerRadii),
          border: Border.all(
              color: _animation.value, width: 4, style: BorderStyle.solid),
          boxShadow: [
            BoxShadow(color: _animation.value, spreadRadius: 12, blurRadius: 25)
          ],
          color: Colors.black,
        ),
        child: Container(
          height: _cardHeight,
          width: _cardWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.black,
          ),
          child: (widget.value == plus4)
              ? SvgPicture.asset('assets/plus4.svg')
              : SvgPicture.asset('assets/wild.svg'),
        ),
      ),
    );
  }
}

class BackFacedUnoCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          vertical: _cardMarginVer, horizontal: _cardMarginHor),
      padding: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(_cardCornerRadii),
        border:
            Border.all(color: Colors.black, width: 4, style: BorderStyle.solid),
        boxShadow: [
          BoxShadow(color: Colors.grey, spreadRadius: 2, blurRadius: 2)
        ],
        color: Colors.black,
      ),
      child: Container(
        height: _cardHeight,
        width: _cardWidth,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(60),
          color: Colors.black,
        ),
        child: Center(
          child: Text(
            'UNO',
            style: TextStyle(
                color: Colors.white, fontFamily: 'Frijole', fontSize: 30),
          ),
        ),
      ),
    );
  }
}

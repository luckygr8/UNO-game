import 'dart:math';

import 'package:flutter/material.dart';
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

class UNOcardData {
  final String type;
  final Color color;
  final String value;

  UNOcardData(this.type, {this.color, this.value});
}

abstract class CardTypes {
  static const String SIMPLE = "simple";
  static const String BLOCK = "block";
  static const String REVERSE = "reverse";
  static const String PLUS4 = "plus4";
  static const String PLUS2 = "plus2";
  static const String WILD = "wild";
  static const String BACK = "back";
}

abstract class CardColors {
  static const Color RED = Colors.red;
  static const Color BLUE = Colors.blue;
  static const Color GREEN = Colors.green;
  static const Color ORANGE = Colors.orange;
}

class UNOcard extends StatefulWidget {
  final UNOcardData data;

  UNOcard(this.data);

  @override
  _UNOcardState createState() => _UNOcardState();
}

class _UNOcardState extends State<UNOcard> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation _animation;

  final _listOfTweens = [
    ColorTween(begin: CardColors.BLUE, end: CardColors.GREEN),
    ColorTween(begin: CardColors.GREEN, end: CardColors.ORANGE),
    ColorTween(begin: CardColors.ORANGE, end: CardColors.RED),
    ColorTween(begin: CardColors.RED, end: CardColors.BLUE),
    ColorTween(begin: CardColors.BLUE, end: CardColors.ORANGE),
    ColorTween(begin: CardColors.RED, end: CardColors.GREEN),
  ];

  ColorTween tween() =>
      _listOfTweens[Random().nextInt(_listOfTweens.length - 1)];

  Widget getFiller() {
    switch (widget.data.type) {
      case CardTypes.BLOCK:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/block.svg'),
        );
      case CardTypes.REVERSE:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/reverse.svg'),
        );
      case CardTypes.PLUS2:
        return Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset('assets/plus2.svg'),
        );
      default:
        return Text(
          widget.data.value,
          style: _cardTextStyle,
        );
    }
  }

  @override
  void initState() {
    if (widget.data.type == CardTypes.PLUS4 ||
        widget.data.type == CardTypes.WILD) {
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
          _controller.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _controller.forward();
        }
      });
      _controller.forward();
    }
    super.initState();
  }

  @override
  void deactivate() {
    if (_controller != null) _controller.dispose();
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.data.type) {
      case CardTypes.SIMPLE:
      case CardTypes.BLOCK:
      case CardTypes.REVERSE:
      case CardTypes.PLUS2:
        return Draggable<UNOcardData>(
          data: widget.data,
          feedback: widget,
          childWhenDragging: UNOcard(UNOcardData(CardTypes.BACK)),
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: _cardMarginVer, horizontal: _cardMarginHor),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_cardCornerRadii),
              border: Border.all(
                  color: widget.data.color, width: 4, style: BorderStyle.solid),
              boxShadow: [
                BoxShadow(
                    color: widget.data.color,
                    spreadRadius: (widget.data.type == CardTypes.PLUS2) ? 8 : 2,
                    blurRadius: 5)
              ],
              color: Colors.white,
            ),
            child: Container(
              height: _cardHeight,
              width: _cardWidth,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(60),
                color: widget.data.color,
              ),
              child: Center(
                child: getFiller(),
              ),
            ),
          ),
        );
      case CardTypes.PLUS4:
      case CardTypes.WILD:
        return Draggable(
          feedback: widget,
          data: widget.data,
          childWhenDragging: UNOcard(UNOcardData(CardTypes.BACK)),
          child: Container(
            margin: EdgeInsets.symmetric(
                vertical: _cardMarginVer, horizontal: _cardMarginHor),
            padding: EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(_cardCornerRadii),
              border: Border.all(
                  color: _animation.value, width: 4, style: BorderStyle.solid),
              boxShadow: [
                BoxShadow(
                    color: _animation.value, spreadRadius: 12, blurRadius: 25)
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
              child: (widget.data.type == CardTypes.PLUS4)
                  ? SvgPicture.asset('assets/plus4.svg')
                  : SvgPicture.asset('assets/wild.svg'),
            ),
          ),
        );
      case CardTypes.BACK:
        return Container(
          margin: EdgeInsets.symmetric(
              vertical: _cardMarginVer, horizontal: _cardMarginHor),
          padding: EdgeInsets.all(15),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(_cardCornerRadii),
            border: Border.all(
                color: Colors.black, width: 4, style: BorderStyle.solid),
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
    return null;
  }
}

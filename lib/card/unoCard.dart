import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:newtest/model/dimens.dart';
import 'package:rainbow_color/rainbow_color.dart';
import 'dart:ui';

//final _cardHeight = window.physicalSize.height/20;
//final _cardWidth = window.physicalSize.width/15;
final _cardHeight = 150.0;
final _cardWidth = 105.0;
final _cardCornerRadii = 25.0;
//final _cardMarginVer = Dimens.height*.04;
//final _cardMarginHor = Dimens.width*.02;
final _cardMarginVer = 30.0;
final _cardMarginHor = 15.0;
final _cardTextStyle = TextStyle(
  fontFamily: 'Frijole',
  fontSize: Dimens.width/8,
  color: Colors.black,
);

class UNOcardData {
  final String type;
  Color color;
  String value;

  UNOcardData(this.type, {this.color, this.value});

  @override
  String toString() {
    return 'UNOcardData{type: $type, color: $color, value: $value}';
  }
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
  static const Color COLOR1 = Colors.amber;
  static const Color COLOR2 = Colors.red;
  static const Color COLOR3 = Colors.green;
  static const Color COLOR4 = Colors.blue;
}

class UNOcard extends StatefulWidget {
  final UNOcardData data;

  UNOcard(this.data);

  @override
  _UNOcardState createState() => _UNOcardState();
}

class _UNOcardState extends State<UNOcard> with SingleTickerProviderStateMixin,AutomaticKeepAliveClientMixin
{
  AnimationController _controller;
  Animation _animation;

  final _listOfTweens = [
  RainbowColorTween([CardColors.COLOR1,CardColors.COLOR2,CardColors.COLOR3,CardColors.COLOR4]),
  RainbowColorTween([CardColors.COLOR2,CardColors.COLOR4,CardColors.COLOR1,CardColors.COLOR3]),
  RainbowColorTween([CardColors.COLOR2,CardColors.COLOR4,CardColors.COLOR3,CardColors.COLOR1]),
  RainbowColorTween([CardColors.COLOR4,CardColors.COLOR1,CardColors.COLOR3,CardColors.COLOR2]),
  ];

  Tween<Color> tween() =>
      _listOfTweens[Random().nextInt(_listOfTweens.length - 1)];

  Widget getFiller() {
    switch (widget.data.type) {
      case CardTypes.BLOCK:
        return Padding(
          padding: EdgeInsets.all(Dimens.ppi*3),
          child: SvgPicture.asset('assets/block.svg'),
        );
      case CardTypes.REVERSE:
        return Padding(
          padding:  EdgeInsets.all(Dimens.ppi*3),
          child: SvgPicture.asset('assets/reverse.svg'),
        );
      case CardTypes.PLUS2:
        return Padding(
          padding:  EdgeInsets.all(Dimens.ppi*3),
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
      _controller =
          AnimationController(vsync: this, duration: Duration(seconds: 3));
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
    //}
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
          onDragStarted: (){
            print('started');
          },
          onDragEnd: (details) {
            print('drag stopped');
          },
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
        break;
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
                borderRadius: BorderRadius.circular(Dimens.ppi*10),
                color: Colors.black,
              ),
              child: (widget.data.type == CardTypes.PLUS4)
                  ? SvgPicture.asset('assets/plus4.svg')
                  : SvgPicture.asset('assets/wild.svg'),
            ),
          ),
        );
        break;
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
              borderRadius: BorderRadius.circular(Dimens.ppi*20),
              color: Colors.black,
            ),
            child: Center(
              child: Text(
                'UNO',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Frijole', fontSize: Dimens.width/20),
              ),
            ),
          ),
        );
    }
    return null;
  }

  @override
  bool get wantKeepAlive => true;
}

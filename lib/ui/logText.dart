import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';

class LogText extends StatelessWidget {
  final String intro;
  final String name;
  final String action;
  final String card;
  final Color cardColor;
  final Color valueColor;

  LogText(
      {this.intro = ' ',
      this.action = ' ',
      this.card = ' ',
      this.cardColor = Colors.white,
      this.name = ' ',
      this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: cardColor,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: RichText(
          text: TextSpan(
            text: '$intro ',
            style: DefaultTextStyle.of(context).style,
            children: <TextSpan>[
              TextSpan(
                  text: '$name ',
                  style: TextStyle(color: Colors.black, fontSize: 30)),
              TextSpan(
                  text: '$action ',
                  style: TextStyle(color: Colors.black45, fontSize: 20)),
              TextSpan(
                  text: '$card ',
                  style: !(card=='PLUS4' || card=='WILD') ? TextStyle(backgroundColor: valueColor, fontSize: 20):TextStyle(
                    fontSize: 30,fontWeight: FontWeight.bold,foreground: Paint()..shader = LinearGradient(colors: [CardColors.COLOR1,CardColors.COLOR2,CardColors.COLOR3,CardColors.COLOR4]).createShader(Rect.fromLTWH(0.0, 0.0, 100.0, 10.0))
                  ))
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:newtest/card/unoCard.dart';
import 'package:newtest/model/player.dart';
import 'package:newtest/screens/gameScreen.dart';
import 'package:provider/provider.dart';

class IntroScreen extends StatelessWidget {
  TextStyle style(double ppi) => TextStyle(
        fontSize: (ppi>3.2)?ppi * 6:ppi*8,
        fontWeight: FontWeight.bold,
      );

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final ppi = MediaQuery.of(context).devicePixelRatio;
    return SafeArea(
      child: ChangeNotifierProvider(
        create: (context) => _DataModel(),
        child: Scaffold(
          body: Center(
            child: Container(
              height: size.height,
              width: size.width,
              child: Column(
                children: <Widget>[
                  Expanded(
                    flex: 40,
                    child: Container(
                      child: Center(
                        child: UNOcard(
                          UNOcardData(CardTypes.WILD),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            'SELECT CARDS',
                            style: style(ppi),
                          ),
                          Card(
                            color: Colors.black,
                            child: Padding(
                              padding: EdgeInsets.all(ppi * 1.5),
                              child: Consumer<_DataModel>(
                                builder: (context, value, child) => Text(
                                  value.numberOfCards.toString(),
                                  style: TextStyle(
                                      fontSize: ppi * 6, color: Colors.grey),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 10,
                    child: Center(
                      child: _Slider(),
                    ),
                  ),
                  Expanded(
                    flex: 7,
                    child: Text(
                      'SELECT OPPONENT',
                      style: style(ppi),
                    ),
                  ),
                  Expanded(
                    flex: 13,
                    child: _DropDown(),
                  ),
                  Expanded(
                    flex: 8,
                    child: _Play(),
                  ),
                  Expanded(
                    flex: 5,
                    child: Container(),
                  ),
                  Expanded(
                    flex: 7,
                    child: Center(
                      child: FittedBox(
                        alignment: Alignment.center,
                        fit: BoxFit.cover,
                        child: Text('UNO is not my m\'fkin copyright tho dogg'),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _Slider extends StatefulWidget {
  @override
  __SliderState createState() => __SliderState();
}

class __SliderState extends State<_Slider> {
  double _value = 10;

  @override
  Widget build(BuildContext context) {
    return Consumer<_DataModel>(
      builder: (context, value, child) => Container(
        child: Slider(
            value: _value,
            min: 5,
            max: 15,
            activeColor: Colors.orange,
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

class _DropDown extends StatefulWidget {
  @override
  __DropDownState createState() => __DropDownState();
}

class __DropDownState extends State<_DropDown> {
  String _current = 'Easy';

  @override
  Widget build(BuildContext context) {
    return Consumer<_DataModel>(
      builder: (context, value, child) => DropdownButton<String>(
        value: _current,
        onChanged: (String newValue) {
          setState(() {
            _current = newValue;
          });
        },
        items: <String>['Easy', 'Medium', 'Hard', 'Crazy']
            .map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: DropDownItemStack(value, (value == 'Easy') ? 'beta' : 'N/A'),
          );
        }).toList(),
      ),
    );
  }
}

class DropDownItemStack extends StatelessWidget {
  final opp, tag;

  DropDownItemStack(this.opp, this.tag);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        LayoutBuilder(
          builder: (context, constraints) => Container(
            margin: EdgeInsets.all(5),
            height: 60,
            width: 200,
          ),
        ),
        Positioned.fill(
          child: Align(
            child: Text(
              opp,
              style: TextStyle(
                fontWeight: FontWeight.w500,
                fontSize: MediaQuery.of(context).devicePixelRatio * 6,
              ),
            ),
            alignment: Alignment(-.7, .4),
          ),
        ),
        Positioned.fill(
          child: Align(
            child: Card(
              child: Padding(
                padding:
                    EdgeInsets.all(MediaQuery.of(context).devicePixelRatio),
                child: Text(
                  tag,
                  style: TextStyle(
                      color: Colors.yellow,
                      fontSize: MediaQuery.of(context).devicePixelRatio * 4),
                ),
              ),
              color: Colors.black,
            ),
            alignment: Alignment(.3, -.5),
          ),
        ),
      ],
    );
  }
}

class _Play extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    double ppi = MediaQuery.of(context).devicePixelRatio;
    return Consumer<_DataModel>(
      builder: (context, value, child) => FlatButton(
        color: Colors.orange[200],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24 / ppi),
        ),
        onPressed: () 
          async {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      GameScreen(Player(1, value.name), value.numberOfCards),
                ),
              );
        },
        child: Padding(
          padding: EdgeInsets.all(30 / ppi),
          child: Text(
            'LET\'S PLAY',
            style: TextStyle(fontSize: ppi * 6, fontWeight: FontWeight.bold),
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

import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';
import 'package:math_expressions/math_expressions.dart';
import 'keyboard.dart';

class ScoresPage extends StatefulWidget {
  ScoresPage({Key key, this.title, this.players}) : super(key: key);

  final String title;
  final List<String> players;

  @override
  _ScoresPageState createState() => _ScoresPageState();
}

class _ScoresPageState extends State<ScoresPage> {
  List<Tuple2<String, List<int>>> _scores;
  var _focusedPlayerIdx = 0;
  var _focusedPlayerText = "";

  @override
  initState() {
    super.initState();
    _scores = widget.players.map((name) => Tuple2(name, List<int>())).toList();
  }

  addScore(String text) {
    if (_focusedPlayerIdx >= 0 && text != "") {
      final player = _scores[_focusedPlayerIdx];

      Parser p = new Parser();
      Expression exp = p.parse(text);

      player.item2.insert(
          0, exp.evaluate(EvaluationType.REAL, new ContextModel()).floor());
    }
  }

  @override
  Widget build(BuildContext context) {
    var _maxScores = _scores.map((s) => s.item2.length).reduce(max);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: Column(children: [
        Expanded(
            child: GridView.builder(
          primary: false,
          padding: const EdgeInsets.all(20.0),
          itemCount: (_scores.length * (2 + _maxScores)),
          gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: _scores.length, childAspectRatio: 2),
          itemBuilder: (BuildContext context, int index) {
            final playerIdx = index % _scores.length;
            final player = _scores[playerIdx];
            if (index < _scores.length) {
              var total = player.item2.fold(0, (t, v) => t + v);
              return Text(
                "${player.item1}\n$total",
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              );
            } else if (index < (_scores.length * 2)) {
              if (playerIdx == _focusedPlayerIdx) {
                if (_focusedPlayerText == "") {
                  return Text("Score", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey));
                } else {
                  return Text(_focusedPlayerText, textAlign: TextAlign.center);
                }
              } else {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _focusedPlayerIdx = playerIdx;
                    });
                  },
                  child: Text("-", textAlign: TextAlign.center, style: TextStyle(color: Colors.grey)),
                );
              }
            } else {
              var scoreIdx = (index / _scores.length).floor() - 2;
              if (scoreIdx < player.item2.length) {
                return Text(
                    "${player.item2[scoreIdx]} (${player.item2.length - scoreIdx})",
                    textAlign: TextAlign.center);
              } else {
                return Text("", textAlign: TextAlign.center);
              }
            }
          },
        )),
        Keyboard(
          onChange: (t) => setState(() { _focusedPlayerText = t; }),
          onDone: (t) => setState(() {
            addScore(t);
            _focusedPlayerIdx = (_focusedPlayerIdx + 1) % _scores.length;
          }),
        ),
        Text("\n"),
      ])),
    );
  }
}

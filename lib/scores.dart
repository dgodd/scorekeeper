import 'package:flutter/material.dart';
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
  List<List<int>> _scores = [];

  addScore(String text) {
    var exp = Parser().parse(text);
    var val = exp.evaluate(EvaluationType.REAL, new ContextModel()).floor();

    if (_scores.length == 0 || _scores[0].length == widget.players.length) {
      _scores.insert(0, []);
    }
    _scores[0].add(val);
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    var totals = widget.players.map((name) => 0).toList(growable: false);
    _scores.forEach((round) => round.asMap().forEach((index, val) => totals[index] += val));

    var playerIdx = (_scores.length > 0) ? _scores[0].length % widget.players.length : 0;
    List<Widget> gridRows = [Text("")];
    widget.players.asMap().forEach((index, name) => gridRows.add(Container(
          color: playerIdx == index ? Colors.lightGreenAccent : null,
          child: Center(child: Text("$name\n${totals[index]}",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold))),
        )));

    _scores.asMap().forEach((roundNum,round) {
      gridRows.add(Center(child: Text((_scores.length - roundNum).toString())));
      widget.players.asMap().forEach((i,name) =>
          gridRows.add(Center(child: Text(
              round.length > i ? round[i].toString() : ""
          )))
      );
    });

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Column(children: [
          Expanded(child: GridView.count(
            crossAxisCount: widget.players.length + 1,
            childAspectRatio: screenWidth / widget.players.length / 50,
            children: gridRows,
          )),
          Keyboard(
            onDone: (t) => setState(() {
                  addScore(t);
                }),
          ),
          Text("\n"),
        ]));
  }
}

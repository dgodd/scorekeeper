import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';
import 'dart:math';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Keeper',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: MyHomePage(title: 'Score Keeper'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Tuple2<String, List<int>>> _scores = [
    Tuple2<String, List<int>>("Dave", [1, 2, 3]),
    Tuple2<String, List<int>>("Cath", [3, 4, 5]),
    Tuple2<String, List<int>>("Miles", [22, 33]),
    Tuple2<String, List<int>>("Ross", [])
  ];
  var _focusedPlayerIdx = 0;

  @override
  Widget build(BuildContext context) {
    var _maxScores = _scores.map((s) => s.item2.length).reduce(max);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
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
              "${player.item1} (${player.item2.length})\n$total",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          } else if (index < (_scores.length * 2)) {
            if (playerIdx == _focusedPlayerIdx) {
              final _ctrl = TextEditingController();
              final _focusNode = FocusNode();
              FocusScope.of(context).requestFocus(_focusNode);

              return TextFormField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _ctrl,
                textAlign: TextAlign.center,
                textInputAction: TextInputAction.next,
                focusNode: _focusNode,
                onFieldSubmitted: (value) {
                  setState(() {
                    if (value != "") {
                      final player = _scores[_focusedPlayerIdx];
                      player.item2.insert(0, int.parse(value));
                    }
                    _ctrl.clear();
                    _focusedPlayerIdx = (_focusedPlayerIdx + 1) % _scores.length;
                  });
                },
                decoration:
                InputDecoration(border: InputBorder.none, hintText: 'Score'),
              );
            } else {
              return GestureDetector(
                  onTap: () {
                  setState(() {
                    _focusedPlayerIdx = playerIdx;
                  });
                },
                  child: Text("S", textAlign: TextAlign.center),
              );
            }
          } else {
            var scoreIdx = (index / _scores.length).floor() - 2;
            if (scoreIdx < player.item2.length) {
              return Text("${player.item2[scoreIdx]}",
                  textAlign: TextAlign.center);
            } else {
              return Text("", textAlign: TextAlign.center);
            }
          }
        },
      )),
    );
  }
}

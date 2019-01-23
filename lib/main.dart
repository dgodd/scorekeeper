import 'package:flutter/material.dart';

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
  List<String> _players = ["Dave", "Cath", "Miles", "Ross"];
  List<int> _scores = [];
  final _inputController = TextEditingController();

  void _addScore() {
    setState(() {
      final value = int.tryParse(_inputController.text) ?? 0;
      _scores.add(value);
      _inputController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
          child: GridView.builder(
        primary: false,
        padding: const EdgeInsets.all(20.0),
        itemCount: _players.length + _scores.length + 2,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _players.length),
        itemBuilder: (BuildContext context, int index) {
          if (index < _players.length) {
            var total = 0;
            for (var i = index; i < _scores.length; i += _players.length) {
              total += _scores[i];
            }
            return Text("${_players[index]}\n$total", textAlign: TextAlign.center);
          } else {
            var scoreIdx = index - _players.length;
            if (scoreIdx < _scores.length) {
              return Text("${_scores[scoreIdx]}", textAlign: TextAlign.center);
            } else if (scoreIdx == _scores.length) {
              return TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _inputController,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Score'),
              );
            } else {
              return FloatingActionButton(
                child: Icon(Icons.add),
                tooltip: 'Add Score',
                onPressed: _addScore,
              );
            }
          }
        },
      )),
    );
  }
}

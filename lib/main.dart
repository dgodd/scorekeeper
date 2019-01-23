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
  List<int> _scores = [1, 2, 7, 8, 9, 10, 11, 12];
  final _inputController = TextEditingController();

  void _addScore() {
    setState(() {
      var value = int.tryParse(_inputController.text) || 0;
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
            return Text("P: ${_players[index]} (${index})");
          } else {
            var scoreIdx = index - _players.length;
            if (scoreIdx < _scores.length) {
              return Text("S: ${_scores[scoreIdx]} (${scoreIdx})");
            } else if (scoreIdx == _scores.length) {
              return TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: _inputController,
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

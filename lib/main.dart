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
        itemCount: (_players.length * 2) + _scores.length,
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _players.length, childAspectRatio: 2),
        itemBuilder: (BuildContext context, int index) {
          if (index < _players.length) {
            var total = 0;
            for (var i = index; i < _scores.length; i += _players.length) {
              total += _scores[i];
            }
            return Text(
              "${_players[index]}\n$total",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          } else if (index < (_players.length * 2)) {
            final ctrl = TextEditingController();
            return Row(children: [
              Expanded(
                  child: TextField(
                autofocus: true,
                keyboardType: TextInputType.number,
                controller: ctrl,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                    border: InputBorder.none, hintText: 'Score'),
              )),
              Expanded(
                  child: FloatingActionButton(
                child: Icon(Icons.add),
                tooltip: 'Add Score',
                onPressed: () {
                  setState(() {
                    final value = int.tryParse(ctrl.text) ?? 0;
                    _scores.add(value);
                    _inputController.clear();
                  });
                },
              ))
            ]);
          } else {
            var scoreIdx = index - (_players.length * 2);
            return Text("${_scores[scoreIdx]}", textAlign: TextAlign.center);
          }
        },
      )),
    );
  }
}

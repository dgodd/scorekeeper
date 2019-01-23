import 'package:flutter/material.dart';
import 'package:tuple/tuple.dart';

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
        itemCount: (_scores.length * (2 + _scores.fold(0, (m, s) => s.item2.length > m ? s.item2.length : m))),
        gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: _scores.length, childAspectRatio: 2),
        itemBuilder: (BuildContext context, int index) {
          final player = _scores[index % _scores.length];
          if (index < _scores.length) {
            var total = player.item2.fold(0, (t, v) => t + v);
            return Text(
              "${player.item1}\n$total",
              textAlign: TextAlign.center,
              style: TextStyle(fontWeight: FontWeight.bold),
            );
          } else if (index < (_scores.length * 2)) {
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
                    player.item2.insert(0, value);
                    ctrl.clear();
                  });
                },
              ))
            ]);
          } else {
            var scoreIdx = (index / _scores.length).floor() - 2;
            if (scoreIdx < player.item2.length) {
              return Text("${player.item2[scoreIdx]}",
                  textAlign: TextAlign.center);
            } else {
              return Text("N/A", textAlign: TextAlign.center);
            }
          }
        },
      )),
    );
  }
}

import 'package:flutter/material.dart';

class Keyboard extends StatefulWidget {
  Keyboard({Key key, @required this.onDone})
      : super(key: key);

  final Function onDone;

  @override
  _Keyboard createState() => new _Keyboard();
}

class _Keyboard extends State<Keyboard> {
  var text = "";

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Text(text),
        text == "" ? Spacer() : IconButton(
          icon: Icon(Icons.backspace),
          tooltip: 'Backspace',
          onPressed: () {
            setState(() {
              text = text.substring(0, text.length - 1);
            });
          },
        ),
      ]),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["1", "2", "3"]
              .map((v) => RaisedButton(
                  child: Text(v, style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () {
                    setState(() {
                      text += v;
                    });
                  }))
              .toList()),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["4", "5", "6"]
              .map((v) => RaisedButton(
                  child: Text(v, style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () {
                    setState(() {
                      text += v;
                    });
                  }))
              .toList()),
      Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: ["7", "8", "9"]
              .map((v) => RaisedButton(
                  child: Text(v, style: TextStyle(color: Colors.white)),
                  color: Colors.green,
                  padding: const EdgeInsets.all(8.0),
                  onPressed: () {
                    setState(() {
                      text += v;
                    });
                  }))
              .toList()),
      Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        IconButton(
          icon: Icon(Icons.add_circle),
          tooltip: 'Add Score',
          onPressed: () {
            setState(() {
              text += "+";
            });
          },
        ),
        RaisedButton(
          child: Text("0", style: TextStyle(color: Colors.white)),
          color: Colors.green,
          padding: const EdgeInsets.all(8.0),
          onPressed: () {
            setState(() {
              text += "0";
            });
          },
        ),
        IconButton(
          icon: Icon(Icons.done),
          tooltip: 'Add Score',
          onPressed: () {
            setState(() {
              widget.onDone(text);
              text = "";
            });
          },
        ),
      ]),
    ]);
  }
}

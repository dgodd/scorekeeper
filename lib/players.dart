import 'package:flutter/material.dart';
import 'scores.dart';

class PlayersPage extends StatefulWidget {
  PlayersPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _PlayersPageState createState() => _PlayersPageState();
}

class _PlayersPageState extends State<PlayersPage> {
  List<String> _players = ["Dave", "Cath", "Miles"];

  @override
  Widget build(BuildContext context) {
    final _ctrl = TextEditingController();

    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
          actions: [
            FlatButton(
                child: const Text("Start", style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 30)),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => ScoresPage(
                            title: 'Score Keeper', players: _players)),
                  );
                })
          ],
        ),
        body: Column(children: [
          Row(children: [
            Expanded(
                child: TextField(
              autofocus: true,
              controller: _ctrl,
              maxLines: 1,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Player to add?',
                labelText: 'Name *',
              ),
              onSubmitted: (String value) {
                setState(() {
                _players.add(value);
                _ctrl.clear();
                });
              },
            )),
          ]),
          Expanded(
              child: ReorderableListView(
                  onReorder: (int oldIndex, int newIndex) {
                    if (oldIndex < newIndex) {
                      // removing the item at oldIndex will shorten the list by 1.
                      newIndex -= 1;
                    }
                    setState(() {
                      final String name = _players.removeAt(oldIndex);
                      _players.insert(newIndex, name);
                    });
                  },
                  children: Iterable<int>.generate(_players.length, (i) => i)
                      .map((index) => ListTile(
                            key: Key("player_$index"),
                            leading: Icon(Icons.person),
                            title: Text(_players[index]),
                            trailing: GestureDetector(
                                child: Icon(Icons.remove_circle),
                                onTap: () {
                                  setState(() {
                                    _players.removeAt(index);
                                  });
                                }),
                          ))
                      .toList())),
        ]));
  }
}

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
  final _ctrl = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        floatingActionButton: FloatingActionButton(
            child: const Icon(Icons.navigate_next),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        ScoresPage(title: 'Score Keeper', players: _players)),
              );
            }),
        body: Column(children: [
          Row(children: [
            Expanded(
                child: TextFormField(
              autofocus: true,
              controller: _ctrl,
              decoration: const InputDecoration(
                icon: Icon(Icons.person),
                hintText: 'Player to add?',
                labelText: 'Name *',
              ),
              onSaved: (String value) {
                _players.add(_ctrl.text);
                _ctrl.clear();
              },
            )),
            IconButton(
              icon: Icon(Icons.done),
              tooltip: 'Add Score',
              onPressed: () {
                setState(() {
                  _players.add(_ctrl.text);
                  _ctrl.clear();
                });
              },
            ),
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

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
          child: const Icon(Icons.navigate_next), onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ScoresPage(title: 'Score Keeper', players: _players)),
          );
          }
        ),
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
              child: ListView.builder(
                  itemCount: _players.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return     ListTile(
                      leading: Icon(Icons.person),
                      title: Text(_players[index]),
                      trailing: GestureDetector(child: Icon(Icons.remove_circle), onTap: () { setState(() {
                        _players.removeAt(index);
                      }); }),
                    );
                  })),
        ]));
  }
}

import 'package:flutter/material.dart';
import 'players.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Score Keeper',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: PlayersPage(title: 'Players - Score Keeper'),
    );
  }
}

import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rock Paper Scissors',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: RPSGame(),
    );
  }
}

enum Choice {
  rock,
  paper,
  scissors,
  none,
}

class RPSGame extends StatefulWidget {
  @override
  _RPSGameState createState() => _RPSGameState();
}

class _RPSGameState extends State<RPSGame> {
  Choice playerChoice = Choice.none;
  Choice computerChoice = Choice.none;
  String result = '';

  void play(Choice choice) {
    setState(() {
      playerChoice = choice;
      computerChoice = _getComputerChoice();
      result = _getResult(playerChoice, computerChoice);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Rock Paper Scissors'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Choose your move:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => play(Choice.rock),
                  child: Text('Rock'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => play(Choice.paper),
                  child: Text('Paper'),
                ),
                SizedBox(width: 20),
                ElevatedButton(
                  onPressed: () => play(Choice.scissors),
                  child: Text('Scissors'),
                ),
              ],
            ),
            SizedBox(height: 20),
            if (playerChoice != Choice.none)
              Text(
                'You chose ${playerChoice
                    .toString()
                    .split('.')
                    .last}',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 10),
            if (computerChoice != Choice.none)
              Text(
                'Computer chose ${computerChoice
                    .toString()
                    .split('.')
                    .last}',
                style: TextStyle(fontSize: 18),
              ),
            SizedBox(height: 20),
            if (result.isNotEmpty)
              Text(
                result,
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
          ],
        ),
      ),
    );
  }

  Choice _getComputerChoice() {
    return Choice.values[Random().nextInt(Choice.values.length - 1)];
  }

  String _getResult(Choice player, Choice computer) {
    if (player == computer) {
      return 'It\'s a tie!';
    } else if ((player == Choice.rock && computer == Choice.scissors) ||
        (player == Choice.paper && computer == Choice.rock) ||
        (player == Choice.scissors && computer == Choice.paper)) {
      return 'You win!';
    } else {
      return 'You lose!';
    }
  }
}

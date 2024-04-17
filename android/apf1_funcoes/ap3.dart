import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

enum GameState {
  Jogando,
  Ganhou,
  Perdeu,
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: Center(
          child: MyWidget(),
        ),
      ),
    );
  }
}

class MyWidget extends StatefulWidget {
  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final random = Random();

  var correctButton = 0;
  var clicks = 0;
  var gameState = GameState.Jogando;
  var wins = 0;
  var losses = 0;

  @override
  void initState() {
    super.initState();
    generateCorrectButton();
  }

  void generateCorrectButton() {
    correctButton = random.nextInt(3);
  }

  void checkAnswer(int option) {
    setState(() {
      if (option == correctButton) {
        gameState = GameState.Ganhou;
        wins++;
      } else {
        clicks++;
        if (clicks >= 2) {
          gameState = GameState.Perdeu;
          losses++;
        }
      }
    });
  }

  void restartGame() {
    setState(() {
      clicks = 0;
      gameState = GameState.Jogando;
      generateCorrectButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    Color backgroundColor;
    switch (gameState) {
      case GameState.Jogando:
        backgroundColor = darkBlue;
        break;
      case GameState.Ganhou:
        backgroundColor = Colors.green;
        break;
      case GameState.Perdeu:
        backgroundColor = Colors.red;
        break;
    }

    return Container(
      color: backgroundColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (gameState == GameState.Jogando)
            Column(
              children: [
                ElevatedButton(
                  child: const Text('A'),
                  onPressed: () {
                    checkAnswer(0);
                  },
                ),
                ElevatedButton(
                  child: const Text('B'),
                  onPressed: () {
                    checkAnswer(1);
                  },
                ),
                ElevatedButton(
                  child: const Text('C'),
                  onPressed: () {
                    checkAnswer(2);
                  },
                ),
              ],
            ),
          if (gameState != GameState.Jogando)
            Container(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    gameState == GameState.Ganhou ? 'Você ganhou' : 'Você perdeu',
                    style: TextStyle(fontSize: 24),
                  ),
                  ElevatedButton(
                    onPressed: restartGame,
                    child: Text('Reiniciar'),
                  ),
                ],
              ),
            ),
          Text('Vitórias: $wins | Derrotas: $losses'),
        ],
      ),
    );
  }
}
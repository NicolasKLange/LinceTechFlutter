import 'package:flutter/material.dart';
import 'dart:math';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

enum GameState {
  jogando,
  ganhou,
  perdeu,
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
  var gameState = GameState.jogando;
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
        gameState = GameState.ganhou;
        wins++;
      } else {
        clicks++;
        if (clicks >= 2) {
          gameState = GameState.perdeu;
          losses++;
        }
      }
    });
  }

  void restartGame() {
    setState(() {
      clicks = 0;
      gameState = GameState.jogando;
      generateCorrectButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    switch (gameState) {
      case GameState.jogando:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
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
        );
      case GameState.ganhou:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.green,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Você ganhou',
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
        );
      case GameState.perdeu:
        return Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              color: Colors.red,
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  Text(
                    'Você perdeu',
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
        );
    }
  }
}

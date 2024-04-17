import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Clique no botao correto!!',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GuessButtonScreen(),
    );
  }
}

class GuessButtonScreen extends StatefulWidget {
  @override
  _GuessButtonScreenState createState() => _GuessButtonScreenState();
}

class _GuessButtonScreenState extends State<GuessButtonScreen> {
  String correctButton = '';
  int attemptsLeft = 2;
  Color backgroundColor = Colors.white;
  String message = ''; // Mensagem a ser exibida se o usuário perder

  @override
  void initState() {
    super.initState();
    generateCorrectButton();
  }

  void generateCorrectButton() {
    Random random = Random();
    int randomNumber = random.nextInt(3);
    setState(() {
      correctButton = String.fromCharCode('A'.codeUnitAt(0) + randomNumber);
    });
  }

  void checkAnswer(String button) {
    setState(() {
      if (button == correctButton) {
        backgroundColor = Colors.green;
        message = ''; // Limpa a mensagem se o usuário acertar
      } else {
        attemptsLeft--;
        if (attemptsLeft == 0) {
          backgroundColor = Colors.red;
          message = 'Você perdeu'; // Define a mensagem se o usuário perder
        }
      }
    });
  }

  void resetGame() {
    setState(() {
      attemptsLeft = 2;
      backgroundColor = Colors.white;
      message = ''; // Limpa a mensagem ao reiniciar o jogo
      generateCorrectButton();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Guess the Button Game'),
      ),
      backgroundColor: backgroundColor,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              message, // Exibe a mensagem se o usuário perder
              style: TextStyle(
                fontSize: 20.0,
                color: Colors.white,
              ),
            ),
            ElevatedButton(
              onPressed: () {
                checkAnswer('A');
              },
              child: Text('A'),
            ),
            ElevatedButton(
              onPressed: () {
                checkAnswer('B');
              },
              child: Text('B'),
            ),
            ElevatedButton(
              onPressed: () {
                checkAnswer('C');
              },
              child: Text('C'),
            ),
            if (backgroundColor != Colors.white)
              SizedBox(height: 20.0),
            if (backgroundColor != Colors.white)
              ElevatedButton(
                onPressed: resetGame,
                child: Text('Reiniciar'),
              ),
          ],
        ),
      ),
    );
  }
}

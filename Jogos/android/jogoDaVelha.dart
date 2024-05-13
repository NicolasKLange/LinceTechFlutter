import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo Da Velha',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: GameScreen(),
    );
  }
}

class GameScreen extends StatefulWidget {
  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> board = List.filled(9, '');
  bool isPlayerXTurn = true;
  int playerXScore = 0;
  int playerOScore = 0;
  List<int> winningSquares = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Jogo Da Velha',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 4.0,
              mainAxisSpacing: 4.0,
            ),
            itemCount: 9,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  if (board[index] == '') {
                    setState(() {
                      if (isPlayerXTurn) {
                        board[index] = 'X';
                      } else {
                        board[index] = 'O';
                      }
                      isPlayerXTurn = !isPlayerXTurn;
                      checkWinner();
                    });
                  }
                },
                child: Container(
                  color: winningSquares.contains(index)
                      ? Colors.green
                      : Colors.grey[300],
                  child: Center(
                    child: Text(
                      board[index],
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0),
          Text(
            'Jogador X: $playerXScore   Jogador O: $playerOScore',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                resetGame();
              });
            },
            child: Text('Recomeçar'),
          ),
        ],
      ),
    );
  }

  void checkWinner() {
    List<List<int>> winningConditions = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condition in winningConditions) {
      if (board[condition[0]] != '' &&
          board[condition[0]] == board[condition[1]] &&
          board[condition[1]] == board[condition[2]]) {
        setState(() {
          winningSquares = List<int>.from(condition);
        });
        if (board[condition[0]] == 'X') {
          playerXScore++;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Jogador X ganhou!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        } else {
          playerOScore++;
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Jogador O ganhou!'),
                actions: [
                  TextButton(
                    onPressed: () {
                      resetGame();
                      Navigator.of(context).pop();
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        }
        return;
      }
    }

    // Check for draw
    if (!board.contains('')) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Velhaaa!'),
            actions: [
              TextButton(
                onPressed: () {
                  resetGame();
                  Navigator.of(context).pop();
                },
                child: Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  void resetGame() {
    setState(() {
      board = List.filled(9, '');
      winningSquares = [];
    });
  }
}



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
      home: TelaDoJogo(),
    );
  }
}

class TelaDoJogo extends StatefulWidget {
  @override
  _TelaDoJogoState createState() => _TelaDoJogoState();
}

class _TelaDoJogoState extends State<TelaDoJogo> {
  List<String> tabuleiro = List.filled(9, '');
  bool vezDoJogadorX = true;
  int pontuacaoJogadorX = 0;
  int pontuacaoJogadorO = 0;
  List<int> quadradosVencedores = [];

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
                  if (tabuleiro[index] == '') {
                    setState(() {
                      if (vezDoJogadorX) {
                        tabuleiro[index] = 'X';
                      } else {
                        tabuleiro[index] = 'O';
                      }
                      vezDoJogadorX = !vezDoJogadorX;
                      verificarVencedor();
                    });
                  }
                },
                child: Container(
                  color: quadradosVencedores.contains(index)
                      ? Colors.green
                      : Colors.grey[300],
                  child: Center(
                    child: Text(
                      tabuleiro[index],
                      style: TextStyle(fontSize: 40.0),
                    ),
                  ),
                ),
              );
            },
          ),
          SizedBox(height: 20.0),
          Text(
            'Jogador X: $pontuacaoJogadorX   Jogador O: $pontuacaoJogadorO',
            style: TextStyle(fontSize: 20.0),
          ),
          SizedBox(height: 20.0),
          ElevatedButton(
            onPressed: () {
              setState(() {
                reiniciarJogo();
              });
            },
            child: Text('Recomeçar'),
          ),
        ],
      ),
    );
  }

  void verificarVencedor() {
    List<List<int>> condicoesVitoria = [
      [0, 1, 2],
      [3, 4, 5],
      [6, 7, 8],
      [0, 3, 6],
      [1, 4, 7],
      [2, 5, 8],
      [0, 4, 8],
      [2, 4, 6],
    ];

    for (var condicao in condicoesVitoria) {
      if (tabuleiro[condicao[0]] != '' &&
          tabuleiro[condicao[0]] == tabuleiro[condicao[1]] &&
          tabuleiro[condicao[1]] == tabuleiro[condicao[2]]) {
        setState(() {
          quadradosVencedores = List<int>.from(condicao);
        });
        if (tabuleiro[condicao[0]] == 'X') {
          pontuacaoJogadorX++;
          mostrarDialogoVitoria('Jogador X');
        } else {
          pontuacaoJogadorO++;
          mostrarDialogoVitoria('Jogador O');
        }
        return;
      }
    }

    // Verifica empate
    if (!tabuleiro.contains('')) {
      mostrarDialogoEmpate();
    }
  }

  void mostrarDialogoVitoria(String vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$vencedor ganhou!'),
          actions: [
            TextButton(
              onPressed: () {
                reiniciarJogo();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void mostrarDialogoEmpate() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Velha!'),
          actions: [
            TextButton(
              onPressed: () {
                reiniciarJogo();
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  void reiniciarJogo() {
    setState(() {
      tabuleiro = List.filled(9, '');
      quadradosVencedores = [];
    });
  }
}
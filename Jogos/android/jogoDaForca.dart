import 'dart:math';

import 'package:flutter/material.dart';

void main() {
  runApp(JogoDaForca());
}

class JogoDaForca extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Jogo da Forca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaDaForca(),
    );
  }
}

class PaginaDaForca extends StatefulWidget {
  @override
  _PaginaDaForcaState createState() => _PaginaDaForcaState();
}

class _PaginaDaForcaState extends State<PaginaDaForca> {
  // Lista de palavras para escolher
  List<String> palavras = ["maçã", "banana", "cereja", "cachorro", "elefante"];

  // Seleciona aleatoriamente uma palavra da lista
  String palavra = "";

  // Inicializa a lista de letras adivinhadas
  List<String> letrasAdivinhadas = [];

  // Inicializa o número de palpites errados
  int palpitesErrados = 0;

  @override
  void initState() {
    super.initState();
    palavra = palavras[Random().nextInt(palavras.length)];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Jogo da Forca'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Exibe o estado atual da palavra
            Text(
              palavra.replaceAllMapped(
                  RegExp(letrasAdivinhadas.isEmpty ? "." : "[^${letrasAdivinhadas.join()}]"),
                      (match) => "_"),
              style: TextStyle(fontSize: 36),
            ),

            // Exibe o número de palpites errados
            Text(
              "Palpites errados: $palpitesErrados",
              style: TextStyle(fontSize: 18),
            ),

            // Exibe as letras que o jogador errou
            Text(
              "Letras erradas: ${_getLetrasErradas()}",
              style: TextStyle(fontSize: 18),
            ),

            // Exibe a lista de letras que o jogador tentou
            Text(
              "Letras: ${letrasAdivinhadas.join(', ')}",
              style: TextStyle(fontSize: 18),
            ),

            // Campo de entrada para adivinhar uma letra
            TextField(
              onSubmitted: (value) {
                // Verifica se o palpite é válido
                if (value.length != 1 || !RegExp(r'[a-z]').hasMatch(value)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Palpite inválido"),
                      content: Text("Por favor, insira apenas uma letra."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                // Verifica se o palpite já foi feito
                if (letrasAdivinhadas.contains(value)) {
                  showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text("Palpite repetido"),
                      content: Text("Você já tentou essa letra."),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text("OK"),
                        ),
                      ],
                    ),
                  );
                  return;
                }

                // Adiciona o palpite à lista de letras adivinhadas
                setState(() {
                  letrasAdivinhadas.add(value);

                  // Verifica se o palpite está correto
                  if (!palavra.contains(value)) {
                    // Incrementa o número de palpites errados
                    palpitesErrados++;

                    // Verifica se o jogador perdeu
                    if (palpitesErrados == 6) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Você perdeu!"),
                          content: Text("A palavra era $palavra."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  } else {
                    // Verifica se o jogador ganhou
                    if (palavra.split('').every((letter) => letrasAdivinhadas.contains(letter))) {
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: Text("Você ganhou!"),
                          content: Text("A palavra era $palavra."),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("OK"),
                            ),
                          ],
                        ),
                      );
                    }
                  }
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  // Retorna uma string com as letras que o jogador errou
  String _getLetrasErradas() {
    List<String> erradas = [];
    for (var letra in letrasAdivinhadas) {
      if (!palavra.contains(letra)) {
        erradas.add(letra);
      }
    }
    return erradas.join(', ');
  }
}
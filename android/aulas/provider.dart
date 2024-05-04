import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => Pessoa(nome: "Nicolas", idade: 18),
      child: MyApp(),
    ),
  );
}

class Pessoa with ChangeNotifier {
  String nome = "";
  int idade = 0;

  Pessoa({required this.nome, required this.idade});

  void incrementaIdade() {
    this.idade++;
    notifyListeners();
  }

  void dimIdade() {
    this.idade--;
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Consumer<Pessoa>(
        builder: (context, pessoa, child) => Scaffold(
          appBar: AppBar(
            title: Center(
              child: Text("Exemplo Provider"),
            ),
          ),
          body: Center(
            child: Text(
              "${pessoa.nome} "
              "tem ${pessoa.idade} anos de idade",
              style: TextStyle(fontSize: 27),
            ),
          ),
          
          floatingActionButton: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              FloatingActionButton(
                //BOTAO PARA SOMAR IDADE
                child: Text(
                  "-",
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () => pessoa.dimIdade(),
              ),
              FloatingActionButton(
                //BOTAO PARA DIMINUIR IDADE
                child: Text(
                  "+",
                  style: TextStyle(fontSize: 40),
                ),
                onPressed: () => pessoa.incrementaIdade(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

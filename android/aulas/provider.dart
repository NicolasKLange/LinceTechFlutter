import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    Provider(
      create: (_) => Pessoa(nome: "Nicolas", idade: 18),
      child: MyApp(),
    ),
  );
}

class Pessoa {
  String nome = "";
  int idade = 0;

  Pessoa({required this.nome, required this.idade});
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(
            child: Text("Exemplo Provider"),
          ),
        ),
        body: Center(
          child: Text(
              "${(context).select((Pessoa p) => p.nome)} tem ${(context).select((Pessoa p) => p.idade)} anos de idade", style: TextStyle(fontSize: 30),),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

void main() {
  int valor = 10;

  runApp(MyApp(titulo: "Cadastramento", valor: valor));
}

class MyApp extends StatelessWidget{
  final String titulo;
  final int valor;
  const MyApp({Key? key, this.titulo = '', this.valor = 0}) : super(key: key);

  @override
    Widget build(BuildContext context) {
      return MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text(this.titulo),
          ),
          body: Center(
            child: Text("Cadastro", style: TextStyle(fontSize: 40, color: Colors.brown),
            ),
          ),
        ),
      );
    }
}    
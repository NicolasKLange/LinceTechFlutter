import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ///Criando uma lista de 20 produtos usando o generate
  List<String> listaProdutos = List<String>.generate(20, (index) => "Produto ${index + 1}"); // Criando uma lista de produtos vazia


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('List View'),
        ),
        body: ListView.builder(
          itemCount: listaProdutos.length,
          itemBuilder: (context, indice) {
            return ListTile(
              title: Text(
                listaProdutos[indice],
                style: TextStyle(fontSize: 40),),
              onTap: (){
                print("O produto selecionao foi o ${listaProdutos[indice]}");
              },
            );
          },
        ),
      ),
    );
  }
}

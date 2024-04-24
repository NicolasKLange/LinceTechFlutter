import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/tela1', //COMECA NA TELA 1
      //LISTA DE ROTAS DO APP COM SEUS NOMES E SUAS FUNCIONALIDADES
      routes: {
        '/tela1': (context) => Tela1(),
        '/tela2': (context) => Tela2(),
      },
    );
  }
}

///ESTRUTURA DA TELA 1
class Tela1 extends StatelessWidget {
  const Tela1({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tela 1 "),
            backgroundColor: Colors.red,
          ),
          body: Center(
            child: ElevatedButton(
              child: Text("Ir para a tela 2"),
              onPressed: () {
                print("Clicou no botao");
                //TROCANDO PARA A TELA 2
                Navigator.pushNamed(context, '/tela2');
              }, //onPressed:
            ),
          ),
        ),
      ),
    );
  }
}

///ESTRUTURA DA TELA 2
class Tela2 extends StatelessWidget {
  const Tela2({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: MaterialApp(
        home: Scaffold(
          appBar: AppBar(
            title: Text("Tela 2 "),
            backgroundColor: Colors.blue,
          ),
          body: Center(
            child: ElevatedButton(
              child: Text("Retornar para a tela 1"),
              onPressed: () {
                //TROCANDO PARA A TELA 1
                Navigator.pushNamed(context, '/tela1');
              },
            ),
          ),
        ),
      ),
    );
  }
}

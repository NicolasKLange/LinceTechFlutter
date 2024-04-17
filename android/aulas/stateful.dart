import 'package:flutter/material.dart';

void main() {
  runApp(MyApp(nome: 'Nicolas',));
}


class MyApp extends StatefulWidget {

  final String nome;

  const MyApp({super.key, this.nome = ''});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int salario = 2000;

  void aumentarSalario(int valor){
    setState(() {
      this.salario += valor;
    });
  }

  void diminuirSalario(int valor){
    setState(() {
      this.salario -= valor;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          print("Clicou");
          diminuirSalario(100);
          },

        child: Text(
          "O salario de ${widget.nome} é $salario",
          textDirection: TextDirection.ltr,),
      ),

    );
  }
}

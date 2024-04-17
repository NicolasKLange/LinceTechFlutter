import 'dart:math';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String texto = "Sortear Cor";
  Color cor = Colors.white;

  List<Color> cores = [
    Colors.pink,
    Colors.blue,
    Colors.green,
    Colors.red,
    Colors.yellow,
  ];

  void sortearCor(){
    setState(() {
      int indiceRandom = Random().nextInt(cores.length);
      cor = cores[indiceRandom];
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: (){
          sortearCor();
        },

        child: Text(
          texto,
          textDirection: TextDirection.ltr, style: TextStyle(fontSize: 40, color: cor),),
      ),

    );
  }
}

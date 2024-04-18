///COLUMN > WIDGET PARA COLUNA

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
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Aplicativo Column'),
        ),
        body: Column(
          ///FAZER O ALINHAMENTO DOS ITENS
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Center(
              child: Text(
                'Coluna 1',
                style: TextStyle(fontSize: 40, color: Colors.lightBlue),
              ),
            ),
            Center(
              child: Text(
                'Coluna 2',
                style: TextStyle(fontSize: 40, color: Colors.red),
              ),
            ),
            Center(
              child: Text(
                'Coluna 3',
                style: TextStyle(fontSize: 40, color: Colors.green),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

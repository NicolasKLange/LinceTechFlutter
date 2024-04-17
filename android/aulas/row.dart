///ROW > WIDGET PARA LINHA

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
          title: Text('Aplicativo Row'),
        ),
        body: Row(
          ///FAZER O ALINHAMENTO DOS ITENS
          mainAxisAlignment: MainAxisAlignment.spaceAround, //coloca um espaco ao redor do objeto
          children: [
            Center(
              child: Text(
                'Aplicativo',
                style: TextStyle(fontSize: 40),
              ),
            ),
            Center(
              child: Text(
                'Aplicativo',
                style: TextStyle(fontSize: 40),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

///STACK > WIDGET PARA IR EMPILHANDO


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
          title: Text('Stack App')
        ),
        body: Stack(
          //alignment: AlignmentDirectional.center, > alinha os container ao centro
          //fit: StackFit.expand, > espande os containers
          children: [
            Container(
              width: 200,
              height: 200,
              color: Colors.lightBlue,
            ),
            //Posiciona o container
            Positioned(
              bottom: 10,  //se desloca 10px em relacao a base
              right: 10, //se desloca 10px em relacao a esquerda
              child: Container(
                width: 150,
                height: 150,
                color: Colors.red,
              ),
            ),
            Positioned(
              top: 10, //se desloca 10px em relacao ao topo
              left: 10, //se desloca 10px em relacao a esquerda
              child: Container(
                width: 100,
                height: 100,
                color: Colors.indigoAccent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

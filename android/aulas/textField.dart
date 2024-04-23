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
          title: Center(child: Text("Pagina de login")),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Insira seus dados",
                style: TextStyle(fontSize: 40),
              ),
              TextField(
                decoration: InputDecoration(
                    //FAZER A DECORACAO DO TEXTO
                    labelText: "E-mail"),
              ),
              TextField(
                decoration: InputDecoration(
                    //FAZER A DECORACAO DO TEXTO
                    labelText: "Senha"),
                obscureText: true, //FAZ COM QUE NAO APARECE A SENHA
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor de fundo do botão
                ),
                onPressed: () {},
                child: Text(
                  "Entrar",
                  style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
              Center(
                child: Text(
                  "Esqueceu sua senha?",
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

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
  String email = '';
  String senha = '';
  bool aceitoTermo = false;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Center(child: Text("Pagina de cadastro")),
        ),
        body: Padding(
          padding: EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                "Insira seus dados",
                style: TextStyle(fontSize: 40),
              ),

              ///E-MAIL
              TextField(
                decoration: InputDecoration(
                  //FAZER A DECORACAO DO TEXTO
                  labelText: "E-mail",
                ),
                onChanged: (text) {
                  email = text;
                },
              ),

              ///SENHA
              TextField(
                decoration: InputDecoration(
                    //FAZER A DECORACAO DO TEXTO
                    labelText: "Senha"),
                obscureText: true, //FAZ COM QUE NAO APARECE A SENHA
                onChanged: (text) {
                  senha = text;
                },
              ),

              Row(
                children: [
                  Checkbox(
                    value: this.aceitoTermo,
                    onChanged: (checked) {
                      setState(() {
                        aceitoTermo = !aceitoTermo;
                      });
                    },
                  ),
                  Text("Concordo com os termos e uso do app"),
                ],
              ),

              ///BOTAO DE ENTRAR
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Cor de fundo do botão
                ),
                onPressed: () {
                  print("Entrar precionado");
                  print(email);
                },
                child: Text(
                  "Entrar",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),

              ///ESQUECEU A SENHA
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

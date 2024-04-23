import 'package:flutter/material.dart';


enum Genero {
  Masculino,
  Feminino,
  Outro
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //criano as variaveis
  String email = '';
  String senha = '';
  bool aceitoTermo = false;
  Genero genero = Genero.Outro;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Center(child: Text("Pagina de cadastro"), //título da pagina
          ),
        ),
        body: Padding( //colocando margin em todo app
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround, //colando espaco igualado
            crossAxisAlignment: CrossAxisAlignment.stretch, //alinhando o botao de entrar(rodape) ao centro com o espcamento completo do app
            children: [
              ///TEXTO PRINCIPAL
              const Text(
                "Insira seus dados",
                style: TextStyle(fontSize: 40), //customizando o texto principal
              ),

              ///E-MAIL
              TextField(
                decoration: const InputDecoration( //FAZER A DECORACAO DO TEXTO
                  labelText: "E-mail",
                ),
                onChanged: (text) {  //fazendo a coleta do email
                  email = text;
                },
              ),

              ///SENHA
              TextField(
                decoration: const InputDecoration( //FAZER A DECORACAO DO TEXTO
                    labelText: "Senha",
                ),
                obscureText: true, //FAZ COM QUE NAO APARECE A SENHA apenas ...
                onChanged: (text) { //fazendo a coleta da senha
                  print(text);
                  senha = text;
                },
              ),

              ///GENERO DA PESSOA
              Row(
                children: [
                  /// Radio button para selecionar gênero masculino
                  Radio<Genero>(
                    value: Genero.Masculino,
                    groupValue: genero,
                    onChanged: (Genero? generoSelecionado) {
                      setState(() {
                        genero = generoSelecionado ?? Genero.Feminino;
                      });
                    },
                  ),
                  const Text("Masculino"),

                  /// Radio button para selecionar gênero feminino
                  Radio<Genero>(
                    value: Genero.Feminino,
                    groupValue: genero,
                    onChanged: (Genero? generoSelecionado) {
                      setState(() {
                        genero = generoSelecionado ?? Genero.Feminino;
                      });
                    },
                  ),
                  const Text("Feminino"),

                  /// Radio button para selecionar outro gênero
                  Radio<Genero>(
                    value: Genero.Outro,
                    groupValue: genero,
                    onChanged: (Genero? generoSelecionado) {
                      setState(() {
                        genero = generoSelecionado ?? Genero.Feminino;
                      });
                    },
                  ),
                  const Text("Outro"),
                ],
              ),


              ///CHECKBOX PARA ACEITAR OS TERMOS
              Row(  //colocando em linha
                children: [
                  Checkbox(
                    value: aceitoTermo,  //instanciando a vaariavel
                    onChanged: (checked) { // vendo se o usuario clicou
                      setState(() {  //setar se o usuario concorda ou nao
                        aceitoTermo = !aceitoTermo;
                      });
                    },
                  ),
                  const Text("Concordo com os termos e uso do app"), //texto que  vai ao lado do checkbox
                ],
              ),

              ///BOTAO DE ENTRAR
              ElevatedButton(
                style: ElevatedButton.styleFrom( //style para o botao de entrar
                  backgroundColor: Colors.blue, // Cor de fundo do botão
                ),
                onPressed: () { //verificando se o usuário clicou no botao
                  print("Entrar precionado");
                },
                child: const Text( //texto do botao
                  "Entrar",
                  style: TextStyle( //style do botao
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),

              ///ESQUECEU A SENHA
              const Center( //alinhando ao centro
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

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

// Classe principal que inicializa o aplicativo
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Define a rota inicial do aplicativo
      initialRoute: '/listaCores',
      // Define as rotas nomeadas do aplicativo
      routes: {
        '/listaCores': (context) => RotaCores(),
        '/corSelecionada': (context) => RotaCor(),
      },
    );
  }
}

// Classe que representa um item da lista de cores
class ItensDaLista {
  // Construtor da classe
  ItensDaLista(this.cor, this.texto);

  // Atributos da classe
  final MaterialColor cor;
  final String texto;
}

// Tela que exibe a lista de cores disponíveis para seleção
class RotaCores extends StatelessWidget {
  // Lista de cores disponíveis
  final listaCores = [
    ItensDaLista(Colors.red, "Vermelho"),
    ItensDaLista(Colors.orange, "Laranja"),
    ItensDaLista(Colors.yellow, "Amarelo"),
    ItensDaLista(Colors.green, "Verde"),
    ItensDaLista(Colors.blue, "Azul"),
    ItensDaLista(Colors.indigo, "Indigo"),
    ItensDaLista(Colors.purple, "Violeta"),
  ];

  // Método para encontrar a posição de uma cor na lista de cores do arco-íris
  int encontrarPosicaoCor(MaterialColor cor) {
    // Lista de cores do arco-íris
    final coresArcoIris = [
      Colors.red,
      Colors.orange,
      Colors.yellow,
      Colors.green,
      Colors.blue,
      Colors.indigo,
      Colors.purple,
    ];
    // Retorna a posição da cor na lista
    return coresArcoIris.indexOf(cor) + 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Selecione uma cor do arco íris",
          style: TextStyle(fontSize: 25), // Definindo o tamanho da fonte
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: listaCores.length,
            itemBuilder: (context, index) {
              final item = listaCores[index];
              return CorItem(item.texto, item.cor);
            },
          ),
        ),
      ),
    );
  }
}

// Tela que exibe a cor selecionada
class RotaCor extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final MaterialColor color =
    ModalRoute.of(context)!.settings.arguments as MaterialColor;
    final int position =
    RotaCores().encontrarPosicaoCor(color); // Posição da cor selecionada

    return Scaffold(
      appBar: AppBar(
        title: Text("Cor selecionada (Posição: $position)"),
      ),
      body: Container(
        color: color, // Cor de fundo da tela
      ),
    );
  }
}

// Widget que representa um item na lista de cores
class CorItem extends StatelessWidget {
  // Construtor da classe
  const CorItem(this.texto, this.cor);

  // Atributos da classe
  final MaterialColor cor;
  final String texto;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Navega para a tela de cor selecionada, passando a cor como argumento
        Navigator.of(context).pushNamed('/corSelecionada', arguments: cor);
      },
      child: Container(
        color: cor, // Cor de fundo do item da lista
        height: 48, // Altura do item da lista
        child: Center(
          child: Text(
            texto, // Texto do item da lista
            style: TextStyle(fontSize: 20), // Estilo de fonte para o texto
          ),
        ),
      ),
    );
  }
}

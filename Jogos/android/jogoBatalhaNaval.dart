import 'dart:math';
import 'package:flutter/material.dart';

/// Função principal que inicia o aplicativo.
void main() {
  runApp(BatalhaNavalApp());
}

/// Classe que define o aplicativo Batalha Naval.
class BatalhaNavalApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Batalha Naval',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: PaginaInicial(),
    );
  }
}

/// Classe que define a página inicial do aplicativo.
class PaginaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha Naval'),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text('Iniciar Jogo'),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => TelaDeJogo()),
            );
          },
        ),
      ),
    );
  }
}

/// Classe que define uma célula do tabuleiro.
class Celula {
  bool temNavio;   // Indica se a célula contém um navio.
  bool foiAtacada; // Indica se a célula já foi atacada.
  int? idNavio;    // Identificador do navio presente na célula, se houver.

  Celula({this.temNavio = false, this.foiAtacada = false, this.idNavio});
}

/// Classe que define o tabuleiro do jogo.
class Tabuleiro {
  final int tamanho;                  // Tamanho do tabuleiro (número de células por lado).
  List<List<Celula>> celulas;         // Lista bidimensional de células.
  int totalNavios = 4;                // Número total de navios no tabuleiro.
  int naviosEncontrados = 0;          // Número de navios encontrados pelo jogador.
  List<int> acertosPorNavio = [];     // Lista que armazena os acertos por navio.

  Tabuleiro({this.tamanho = 10}) : celulas = List.generate(10, (_) => List.generate(10, (_) => Celula()));

  /// Posiciona os navios aleatoriamente no tabuleiro.
  void posicionarNaviosAleatoriamente() {
    List<int> tamanhosNavios = [2, 3, 4, 5];  // Tamanhos dos navios.
    Random random = Random();

    for (int i = 0; i < tamanhosNavios.length; i++) {
      int tamanho = tamanhosNavios[i];
      bool posicionado = false;

      while (!posicionado) {
        int x = random.nextInt(this.tamanho - (tamanho - 1));  // Calcula a posição inicial x.
        int y = random.nextInt(this.tamanho - (tamanho - 1));  // Calcula a posição inicial y.
        bool horizontal = random.nextBool();  // Define se o navio será posicionado horizontalmente ou verticalmente.
        posicionado = _posicionarNavio(x, y, tamanho, horizontal, i);
      }
    }
  }

  /// Tenta posicionar um navio no tabuleiro.
  bool _posicionarNavio(int x, int y, int tamanho, bool horizontal, int idNavio) {
    if (horizontal) {
      for (int i = 0; i < tamanho; i++) {
        if (celulas[x + i][y].temNavio) {
          return false;  // Se alguma célula já contém um navio, retorna falso.
        }
      }
      for (int i = 0; i < tamanho; i++) {
        celulas[x + i][y].temNavio = true;
        celulas[x + i][y].idNavio = idNavio;
      }
    } else {
      for (int i = 0; i < tamanho; i++) {
        if (celulas[x][y + i].temNavio) {
          return false;  // Se alguma célula já contém um navio, retorna falso.
        }
      }
      for (int i = 0; i < tamanho; i++) {
        celulas[x][y + i].temNavio = true;
        celulas[x][y + i].idNavio = idNavio;
      }
    }
    acertosPorNavio.add(tamanho);
    return true;
  }

  /// Realiza um ataque em uma célula do tabuleiro.
  bool atacar(int x, int y) {
    if (celulas[x][y].foiAtacada) {
      return false; // Se a célula já foi atacada, retorna falso.
    }
    celulas[x][y].foiAtacada = true;
    if (celulas[x][y].temNavio) {
      acertosPorNavio[celulas[x][y].idNavio!]--;
      if (acertosPorNavio[celulas[x][y].idNavio!] == 0) {
        naviosEncontrados++;
      }
    }
    return celulas[x][y].temNavio;
  }

  /// Verifica se todos os navios foram encontrados.
  bool todosNaviosEncontrados() {
    return naviosEncontrados == totalNavios;
  }
}

/// Classe que define a tela principal do jogo.
class TelaDeJogo extends StatefulWidget {
  @override
  _TelaDeJogoState createState() => _TelaDeJogoState();
}

class _TelaDeJogoState extends State<TelaDeJogo> {
  Tabuleiro tabuleiroJogador = Tabuleiro();
  Tabuleiro tabuleiroOponente = Tabuleiro();
  int tentativasJogador = 0;
  int tentativasOponente = 0;
  bool turnoJogador = true;

  @override
  void initState() {
    super.initState();
    tabuleiroJogador.posicionarNaviosAleatoriamente();
    tabuleiroOponente.posicionarNaviosAleatoriamente();
  }

  /// Lida com o toque em uma célula do tabuleiro.
  void _aoTocarCelula(int x, int y) {
    setState(() {
      if (turnoJogador) {
        tabuleiroOponente.atacar(x, y);
        tentativasJogador++;
        if (tentativasJogador == 3) {
          turnoJogador = false;
          tentativasJogador = 0;
        }
      } else {
        tabuleiroJogador.atacar(x, y);
        tentativasOponente++;
        if (tentativasOponente == 3) {
          turnoJogador = true;
          tentativasOponente = 0;
        }
      }

      if (tabuleiroOponente.todosNaviosEncontrados()) {
        _mostrarDialogoVitoria('Jogador');
      } else if (tabuleiroJogador.todosNaviosEncontrados()) {
        _mostrarDialogoVitoria('Oponente');
      }
    });
  }

  /// Mostra um diálogo de vitória.
  void _mostrarDialogoVitoria(String vencedor) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('$vencedor Ganhou!'),
          content: Text('$vencedor destruiu todos os navios do oponente!'),
          actions: [
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
                setState(() {
                  tabuleiroJogador = Tabuleiro();
                  tabuleiroOponente = Tabuleiro();
                  tabuleiroJogador.posicionarNaviosAleatoriamente();
                  tabuleiroOponente.posicionarNaviosAleatoriamente();
                  tentativasJogador = 0;
                  tentativasOponente = 0;
                  turnoJogador = true;
                });
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Batalha Naval'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Text('Tabuleiro do Oponente', style: TextStyle(fontSize: 25, color: Colors.red)),
            AspectRatio(
              aspectRatio: 1,
              child: TabuleiroWidget(tabuleiro: tabuleiroOponente, aoTocarCelula: turnoJogador ? _aoTocarCelula : null),
            ),
            Text('Seu Tabuleiro', style: TextStyle(fontSize: 25, color: Colors.red)),
            AspectRatio(
              aspectRatio: 1,
              child: TabuleiroWidget(tabuleiro: tabuleiroJogador, aoTocarCelula: !turnoJogador ? _aoTocarCelula : null),
            ),
          ],
        ),
      ),
    );
  }
}

/// Classe que define o widget do tabuleiro.
class TabuleiroWidget extends StatelessWidget {
  final Tabuleiro tabuleiro;            // O tabuleiro a ser exibido.
  final Function(int, int)? aoTocarCelula; // Função a ser chamada quando uma célula é tocada.

  TabuleiroWidget({required this.tabuleiro, this.aoTocarCelula});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: NeverScrollableScrollPhysics(), // Desativa a rolagem do GridView.
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: tabuleiro.tamanho,
        childAspectRatio: 1,
      ),
      itemBuilder: (context, index) {
        int x = index % tabuleiro.tamanho;
        int y = index ~/ tabuleiro.tamanho;
        return CelulaWidget(
          celula: tabuleiro.celulas[x][y],
          onTap: aoTocarCelula != null ? () => aoTocarCelula!(x, y) : null,
        );
      },
      itemCount: tabuleiro.tamanho * tabuleiro.tamanho,
      padding: EdgeInsets.all(8),
    );
  }
}

/// Classe que define o widget de uma célula.
class CelulaWidget extends StatelessWidget {
  final Celula celula;      // A célula a ser exibida.
  final VoidCallback? onTap; // Função a ser chamada quando a célula é tocada.

  CelulaWidget({required this.celula, this.onTap});

  @override
  Widget build(BuildContext context) {
    Color cor;
    if (celula.foiAtacada) {
      cor = celula.temNavio ? Colors.red : Colors.grey;
    } else {
      cor = Colors.blue;
    }
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.all(1.0),
        width: 20,
        height: 20,
        color: cor,
      ),
    );
  }
}

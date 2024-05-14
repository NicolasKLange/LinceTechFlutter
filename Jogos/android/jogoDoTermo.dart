import 'package:flutter/material.dart';

void main() {
  runApp(TermoApp());
}

class TermoApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adivinhe o Termo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TermoPage(),
    );
  }
}

class TermoPage extends StatefulWidget {
  @override
  _TermoPageState createState() => _TermoPageState();
}

class _TermoPageState extends State<TermoPage> {
  List<String> termos = [
    "garfo",
    "mesa",
    "livro",
    "papel",
    "caneta",
    "copo",
    "mouse",
    "teclado",
    "celular"
  ];

  String termo = "";
  List<List<String>> feedbacks = [];
  List<String> tentativas = [];
  int numTentativas = 0;
  TextEditingController _controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    _gerarTermo();
  }

  void _gerarTermo() {
    setState(() {
      termos.shuffle();
      termo = termos.first;
      feedbacks.clear();
      tentativas.clear();
      numTentativas = 0;
    });
  }

  void _adivinharTermo(String tentativa) {
    setState(() {
      feedbacks.clear();
      tentativas.add(tentativa);
      numTentativas++;

      for (int i = 0; i < tentativas.length; i++) {
        List<String> feedback = [];
        for (int j = 0; j < 5; j++) {
          if (tentativas[i][j] == termo[j]) {
            feedback.add("green");
          } else if (termo.contains(tentativas[i][j])) {
            feedback.add("yellow");
          } else {
            feedback.add("grey");
          }
        }
        feedbacks.add(feedback);
      }

      if (numTentativas >= 5 && !tentativas.contains(termo)) {
        _mostrarDialog("Você perdeu! O termo era: $termo");
      }
    });

    if (tentativa == termo) {
      _mostrarDialog("Parabéns! Você acertou o termo: $termo");
    } else {
      _mostrarFeedbackDialog();
    }
  }

  void _mostrarFeedbackDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Feedback"),
        content: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            tentativas.length,
            (i) => Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: List.generate(
                5,
                (index) => Container(
                  width: 40,
                  height: 40,
                  color: feedbacks.isNotEmpty && feedbacks.length > i
                      ? feedbacks[i][index] == "green"
                          ? Colors.green
                          : feedbacks[i][index] == "yellow"
                              ? Colors.yellow
                              : Colors.grey
                      : Colors.white,
                  child: Center(
                    child: Text(
                      tentativas[i][index],
                      style: TextStyle(
                        color: feedbacks.isNotEmpty && feedbacks.length > i
                            ? feedbacks[i][index] == "yellow" ||
                                    feedbacks[i][index] == "green"
                                ? Colors.white
                                : Colors.black
                            : Colors.black,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _controller.clear();
              });
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  void _mostrarDialog(String message) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                _controller.clear();
                _gerarTermo();
              });
              Navigator.pop(context);
            },
            child: Text("OK"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Adivinhe o Termo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Tente adivinhar o termo!",
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _controller,
              maxLength: 5,
              decoration: InputDecoration(
                hintText: "Digite sua tentativa",
              ),
              onChanged: (value) {
                if (value.length == 5) {
                  _adivinharTermo(value);
                }
              },
            ),
            SizedBox(height: 20),
            Text(
              "Tentativas anteriores:",
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Column(
              children: tentativas
                  .map(
                    (tentativa) => Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: List.generate(
                        5,
                        (index) => Container(
                          width: 40,
                          height: 40,
                          color: feedbacks.isNotEmpty &&
                                  feedbacks.length ==
                                      tentativas.indexOf(tentativa) + 1
                              ? feedbacks[tentativas.indexOf(tentativa)]
                                          [index] ==
                                      "green"
                                  ? Colors.green
                                  : feedbacks[tentativas.indexOf(tentativa)]
                                              [index] ==
                                          "yellow"
                                      ? Colors.yellow
                                      : Colors.grey
                              : Colors.white,
                          child: Center(
                            child: Text(
                              tentativa[index],
                              style: TextStyle(
                                color: feedbacks.isNotEmpty &&
                                        feedbacks.length ==
                                            tentativas.indexOf(tentativa) + 1
                                    ? feedbacks[tentativas.indexOf(tentativa)]
                                                    [index] ==
                                                "yellow" ||
                                            feedbacks[tentativas.indexOf(
                                                    tentativa)][index] ==
                                                "green"
                                        ? Colors.white
                                        : Colors.black
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _gerarTermo();
              },
              child: Text("Reiniciar"),
            ),
          ],
        ),
      ),
    );
  }
}

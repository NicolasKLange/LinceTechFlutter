import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

enum TipoSanguineo {
  aPositivo,
  aNegativo,
  bPositivo,
  bNegativo,
  oPositivo,
  oNegativo,
  abPositivo,
  abNegativo,
}

class Pessoa {
  final String nome;
  final String email;
  final String telefone;
  final String github;
  final TipoSanguineo tipoSanguineo;

  Pessoa({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.github,
    required this.tipoSanguineo,
  });
}

class ListaDePessoas extends ChangeNotifier {
  final List<Pessoa> _pessoas = [];

  List<Pessoa> get pessoas => List.unmodifiable(_pessoas);

  void adicionar(Pessoa pessoa) {
    _pessoas.add(pessoa);
    notifyListeners();
  }

  void remover(Pessoa pessoa) {
    _pessoas.remove(pessoa);
    notifyListeners();
  }
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => ListaDePessoas(),
      child: MaterialApp(
        title: 'Cadastro de Pessoas',
        initialRoute: '/',
        routes: {
          '/': (context) => TelaInicial(),
          '/listagem': (context) => TelaListagem(),
          '/cadastro': (context) => TelaCadastro(),
        },
      ),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tela Inicial',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/listagem'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue, // Cor de fundo azul
              ),
              child: Text(
                'Ver Lista de Pessoas',
                style: TextStyle(fontSize: 20, color: Colors.white), // Texto branco
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => Navigator.pushNamed(context, '/cadastro'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
              ),
              child: Text(
                'Cadastrar Nova Pessoa',
                style: TextStyle(fontSize: 20, color: Colors.white), // Texto branco
              ),
            ),
          ],
        ),
      ),
    );
  }
}


class TelaListagem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final listaDePessoas = Provider.of<ListaDePessoas>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Lista de Pessoas',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: ListView.builder(
        itemCount: listaDePessoas.pessoas.length,
        itemBuilder: (context, index) {
          final pessoa = listaDePessoas.pessoas[index];
          Color cor;
          switch (pessoa.tipoSanguineo) {
            case TipoSanguineo.aPositivo:
              cor = Colors.blue;
              break;
            case TipoSanguineo.aNegativo:
              cor = Colors.red;
              break;
            case TipoSanguineo.bPositivo:
              cor = Colors.purple;
              break;
            case TipoSanguineo.bNegativo:
              cor = Colors.orange;
              break;
            case TipoSanguineo.oPositivo:
              cor = Colors.green;
              break;
            case TipoSanguineo.oNegativo:
              cor = Colors.yellow;
              break;
            case TipoSanguineo.abPositivo:
              cor = Colors.cyan;
              break;
            case TipoSanguineo.abNegativo:
              cor = Colors.white24;
              break;
          }
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaDetalhesPessoa(pessoa: pessoa),
                ),
              );
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: cor,
                child: Text(pessoa.nome[0]),
              ),
              title: Text(pessoa.nome),
              subtitle: Text(pessoa.email),
              trailing: IconButton(
                icon: Icon(Icons.delete),
                onPressed: () => listaDePessoas.remover(pessoa),
              ),
            ),
          );
        },
      ),
    );
  }
}

class TelaCadastro extends StatelessWidget {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _emailController = TextEditingController();
  final _telefoneController = TextEditingController();
  final _githubController = TextEditingController();
  TipoSanguineo? _tipoSanguineoSelecionado;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Cadastro de Pessoa',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nomeController,
                decoration: InputDecoration(
                  label: Text(
                    'Nome Completo',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Por favor, insira o nome.' : null,
              ),
              TextFormField(
                controller: _emailController,
                decoration: InputDecoration(
                  label: Text(
                    'E-mail',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Por favor, insira o e-mail.';
                  } else if (!value.contains('@')) {
                    return 'E-mail inválido.';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _telefoneController,
                decoration: InputDecoration(
                  label: Text(
                    'Telefone',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                validator: (value) =>
                value!.isEmpty ? 'Por favor, insira o telefone.' : null,
              ),
              TextFormField(
                controller: _githubController,
                decoration: InputDecoration(
                  label: Text(
                    'Link do GitHub',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
                // GitHub não é obrigatório, portanto, não adicionaremos validação
              ),
              DropdownButtonFormField<TipoSanguineo>(
                value: _tipoSanguineoSelecionado,
                onChanged: (value) {
                  _tipoSanguineoSelecionado = value;
                },
                items: TipoSanguineo.values
                    .map((tipo) => DropdownMenuItem(
                  value: tipo,
                  child: Text(tipo.toString().split('.').last),
                ))
                    .toList(),
                decoration: InputDecoration(
                  label: Text(
                    'Tipo Sanguíneo',
                    style: TextStyle(fontSize: 18),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16.0),
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      final pessoa = Pessoa(
                        nome: _nomeController.text,
                        email: _emailController.text,
                        telefone: _telefoneController.text,
                        github: _githubController.text,
                        tipoSanguineo: _tipoSanguineoSelecionado!,
                      );
                      Provider.of<ListaDePessoas>(context, listen: false)
                          .adicionar(pessoa);
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Cor de fundo azul
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Salvar',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white, // Texto branco
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class TelaDetalhesPessoa extends StatelessWidget {
  final Pessoa pessoa;

  const TelaDetalhesPessoa({required this.pessoa});

  @override
  Widget build(BuildContext context) {
    Color cor;
    switch (pessoa.tipoSanguineo) {
      case TipoSanguineo.aPositivo:
        cor = Colors.blue;
        break;
      case TipoSanguineo.aNegativo:
        cor = Colors.red;
        break;
      case TipoSanguineo.bPositivo:
        cor = Colors.purple;
        break;
      case TipoSanguineo.bNegativo:
        cor = Colors.orange;
        break;
      case TipoSanguineo.oPositivo:
        cor = Colors.green;
        break;
      case TipoSanguineo.oNegativo:
        cor = Colors.yellow;
        break;
      case TipoSanguineo.abPositivo:
        cor = Colors.cyan;
        break;
      case TipoSanguineo.abNegativo:
        cor = Colors.white24;
        break;
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Informações pesoais",
          style: TextStyle(fontSize: 30),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: cor,
                ),
                alignment: Alignment.center,
                child: Text(
                  _obterTipoSanguineoAbreviado(pessoa.tipoSanguineo),
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Nome: ${pessoa.nome}',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 8,
            ),
            Text(
              'E-mail: ${pessoa.email}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Telefone: ${pessoa.telefone}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Link do GitHub: ${pessoa.github}',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 8),
            Text(
              'Tipo Sanguíneo: ${_obterTipoSanguineo(pessoa.tipoSanguineo)}',
              style: TextStyle(fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  String _obterTipoSanguineo(TipoSanguineo tipoSanguineo) {
    switch (tipoSanguineo) {
      case TipoSanguineo.aPositivo:
        return 'A+';
      case TipoSanguineo.aNegativo:
        return 'A-';
      case TipoSanguineo.bPositivo:
        return 'B+';
      case TipoSanguineo.bNegativo:
        return 'B-';
      case TipoSanguineo.oPositivo:
        return 'O+';
      case TipoSanguineo.oNegativo:
        return 'O-';
      case TipoSanguineo.abPositivo:
        return 'AB+';
      case TipoSanguineo.abNegativo:
        return 'AB-';
    }
  }

  String _obterTipoSanguineoAbreviado(TipoSanguineo tipoSanguineo) {
    switch (tipoSanguineo) {
      case TipoSanguineo.aPositivo:
        return 'A+';
      case TipoSanguineo.aNegativo:
        return 'A-';
      case TipoSanguineo.bPositivo:
        return 'B+';
      case TipoSanguineo.bNegativo:
        return 'B-';
      case TipoSanguineo.oPositivo:
        return 'O+';
      case TipoSanguineo.oNegativo:
        return 'O-';
      case TipoSanguineo.abPositivo:
        return 'AB+';
      case TipoSanguineo.abNegativo:
        return 'AB-';
    }
  }
}

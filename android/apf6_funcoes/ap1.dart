import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

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
  const Pessoa({
    required this.nome,
    required this.email,
    required this.telefone,
    required this.github,
    required this.tipoSanguineo,
  });

  final String nome;
  final String email;
  final String telefone;
  final String github;
  final TipoSanguineo tipoSanguineo;
}

class EstadoListaDePessoas with ChangeNotifier {
  final _listaDePessoas = <Pessoa>[];

  List<Pessoa> get pessoas => List.unmodifiable(_listaDePessoas);

  void incluir(Pessoa pessoa) {
    _listaDePessoas.add(pessoa);
    notifyListeners();
  }

  void excluir(Pessoa pessoa) {
    _listaDePessoas.remove(pessoa);
    notifyListeners();
  }

//
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => EstadoListaDePessoas(),
      child: MaterialApp(
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: darkBlue,
        ),
        debugShowCheckedModeBanner: false,
        initialRoute: '/',
        routes: {
          '/': (context) => TelaInicial(),
          '/listagem': (context) => TelaListagem(),
          '/inclusao_edicao': (context) => TelaInclusaoEdicao(),
        },
      ),
    );
  }
}

class TelaInicial extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Tela Inicial')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/listagem');
              },
              child: Text('Ver Lista de Pessoas'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/inclusao_edicao');
              },
              child: Text('Incluir Nova Pessoa'),
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
    final listaDePessoas = Provider.of<EstadoListaDePessoas>(context);

    return Scaffold(
      appBar: AppBar(title: Text('Listagem de Pessoas')),
      body: Column(
        children: [
          TextField(
            onChanged: (value) {
              // Implementar a lógica de filtragem
            },
            decoration: InputDecoration(
              hintText: 'Filtrar por nome...',
              prefixIcon: Icon(Icons.search),
            ),
          ),
          Expanded(
            child: ListView.builder(
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
                    cor = Colors.white;
                    break;
                }
                return ListTile(
                  title: Text(pessoa.nome),
                  subtitle: Text(pessoa.email),
                  leading: CircleAvatar(
                    backgroundColor: cor,
                    child: Text(pessoa.nome[0]),
                  ),
                  onTap: () {
                    // Implementar ação de visualizar/editar pessoa
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class TelaInclusaoEdicao extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Incluir/Editar Pessoa')),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Form(
          // Implementar formulário de inclusão/editação aqui
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                decoration: InputDecoration(labelText: 'Nome Completo'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'E-mail'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Telefone'),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Link do GitHub'),
              ),
              DropdownButtonFormField<TipoSanguineo>(
                decoration: InputDecoration(labelText: 'Tipo Sanguíneo'),
                items: TipoSanguineo.values
                    .map((tipo) => DropdownMenuItem(
                  child: Text(tipo.toString().split('.').last),
                  value: tipo,
                ))
                    .toList(),
                onChanged: (value) {
                  // Implementar lógica de seleção do tipo sanguíneo
                },
              ),
              ElevatedButton(
                onPressed: () {
                  // Implementar ação de salvar pessoa
                },
                child: Text('Salvar'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

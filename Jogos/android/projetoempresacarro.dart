import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

/// Classe principal do aplicativo que configura o tema e define a tela inicial.
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'App de Loja de Carros',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: TelaLogin(),
    );
  }
}

/// Modelo de dados para representar um carro.
class Carro {
  final String marca;
  final String modelo;
  final double preco;

  Carro({required this.marca, required this.modelo, required this.preco});
}

/// Tela de login onde o usuário pode entrar no aplicativo.
class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}

class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();

  /// Função para simular o login do usuário e navegar para a tela de lista de carros.
  void _login() {
    // Implementar lógica de login
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => TelaListaCarros()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            TextField(
              controller: _controladorUsuario,
              decoration: InputDecoration(labelText: 'Usuário'),
            ),
            TextField(
              controller: _controladorSenha,
              decoration: InputDecoration(labelText: 'Senha'),
              obscureText: true,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _login,
              child: Text('Entrar'),
            ),
          ],
        ),
      ),
    );
  }
}

/// Tela que exibe a lista de carros disponíveis para compra.
class TelaListaCarros extends StatefulWidget {
  @override
  _TelaListaCarrosState createState() => _TelaListaCarrosState();
}

class _TelaListaCarrosState extends State<TelaListaCarros> {
  List<Carro> carros = [
    Carro(marca: 'Toyota', modelo: 'Corolla', preco: 20000),
    Carro(marca: 'Honda', modelo: 'Civic', preco: 22000),
    Carro(marca: 'Ford', modelo: 'Focus', preco: 21000),
    Carro(marca: 'Chevrolet', modelo: 'Cruze', preco: 23000),
    Carro(marca: 'Volkswagen', modelo: 'Jetta', preco: 24000),
    Carro(marca: 'Nissan', modelo: 'Sentra', preco: 19500),
    Carro(marca: 'Hyundai', modelo: 'Elantra', preco: 22500),
    Carro(marca: 'Kia', modelo: 'Cerato', preco: 21500),
    Carro(marca: 'Toyota', modelo: 'Camry', preco: 25000),
    Carro(marca: 'Honda', modelo: 'Accord', preco: 26000),
    Carro(marca: 'Ford', modelo: 'Fusion', preco: 27000),
    Carro(marca: 'Chevrolet', modelo: 'Malibu', preco: 28000),
    Carro(marca: 'Volkswagen', modelo: 'Passat', preco: 29000),
    Carro(marca: 'Nissan', modelo: 'Altima', preco: 30000),
    Carro(marca: 'Hyundai', modelo: 'Sonata', preco: 31000),
    Carro(marca: 'Kia', modelo: 'Optima', preco: 32000),
    Carro(marca: 'Toyota', modelo: 'Avalon', preco: 33000),
  ];

  List<Carro> carrosFiltrados = [];
  List<Carro> carrinho = [];

  @override
  void initState() {
    super.initState();
    carrosFiltrados = carros;
  }

  /// Filtra a lista de carros com base na marca.
  void _filtrarCarros(String marca) {
    setState(() {
      if (marca.isEmpty) {
        carrosFiltrados = carros;
      } else {
        carrosFiltrados = carros.where((carro) => carro.marca.toLowerCase().contains(marca.toLowerCase())).toList();
      }
    });
  }

  /// Adiciona um carro ao carrinho.
  void _adicionarAoCarrinho(Carro carro) {
    setState(() {
      carrinho.add(carro);
    });
  }

  /// Remove um carro do carrinho.
  void _removerDoCarrinho(Carro carro) {
    setState(() {
      carrinho.remove(carro);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Carros'),
        actions: [
          IconButton(
            icon: Icon(Icons.filter_list),
            onPressed: () {
              _mostrarDialogoFiltro();
            },
          ),
          IconButton(
            icon: Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaCarro(carrinho: carrinho, onRemove: _removerDoCarrinho),
                ),
              );
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: carrosFiltrados.length,
        itemBuilder: (context, index) {
          final carro = carrosFiltrados[index];
          return ListTile(
            title: Text('${carro.marca} ${carro.modelo}'),
            subtitle: Text('R\$${carro.preco.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.add_shopping_cart),
              onPressed: () => _adicionarAoCarrinho(carro),
            ),
          );
        },
      ),
    );
  }

  /// Mostra um diálogo para filtrar carros por marca.
  void _mostrarDialogoFiltro() {
    showDialog(
      context: context,
      builder: (context) {
        String filtroMarca = '';
        return AlertDialog(
          title: Text('Filtrar Carros'),
          content: TextField(
            onChanged: (value) {
              filtroMarca = value;
            },
            decoration: InputDecoration(labelText: 'Marca'),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                _filtrarCarros(filtroMarca);
              },
              child: Text('Filtrar'),
            ),
          ],
        );
      },
    );
  }
}

/// Tela que exibe os carros adicionados ao carrinho.
class TelaCarro extends StatefulWidget {
  final List<Carro> carrinho;
  final Function(Carro) onRemove;

  TelaCarro({required this.carrinho, required this.onRemove});

  @override
  _TelaCarroState createState() => _TelaCarroState();
}

class _TelaCarroState extends State<TelaCarro> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu Carrinho'),
      ),
      body: ListView.builder(
        itemCount: widget.carrinho.length,
        itemBuilder: (context, index) {
          final carro = widget.carrinho[index];
          return ListTile(
            title: Text('${carro.marca} ${carro.modelo}'),
            subtitle: Text('R\$${carro.preco.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () {
                setState(() {
                  widget.onRemove(carro);
                });
              },
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => TelaDetalheCarro(carro: carro),
                ),
              );
            },
          );
        },
      ),
    );
  }
}

/// Tela que exibe os detalhes de um carro específico.
class TelaDetalheCarro extends StatelessWidget {
  final Carro carro;

  TelaDetalheCarro({required this.carro});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${carro.marca} ${carro.modelo}'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Marca: ${carro.marca}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Modelo: ${carro.modelo}', style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('Preço: R\$${carro.preco.toStringAsFixed(2)}', style: TextStyle(fontSize: 20)),
            Spacer(),
            ElevatedButton(
              onPressed: () {
                // Implementar lógica de compra
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Carro comprado com sucesso!')),
                );
              },
              child: Center(child: Text('Comprar Agora')),
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';


void main() {
  runApp(MyApp());
}


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


class Carro {
  final String marca;
  final String modelo;
  final double preco;


  Carro({required this.marca, required this.modelo, required this.preco});
}


class TelaLogin extends StatefulWidget {
  @override
  _TelaLoginState createState() => _TelaLoginState();
}


class _TelaLoginState extends State<TelaLogin> {
  final TextEditingController _controladorUsuario = TextEditingController();
  final TextEditingController _controladorSenha = TextEditingController();


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


class TelaListaCarros extends StatefulWidget {
  @override
  _TelaListaCarrosState createState() => _TelaListaCarrosState();
}


class _TelaListaCarrosState extends State<TelaListaCarros> {
  List<Carro> carros = [
    Carro(marca: 'Toyota', modelo: 'Corolla', preco: 20000),
    Carro(marca: 'Honda', modelo: 'Civic', preco: 22000),
    Carro(marca: 'Ford', modelo: 'Focus', preco: 21000),
  ];


  List<Carro> carrosFiltrados = [];
  List<Carro> carrinho = [];


  @override
  void initState() {
    super.initState();
    carrosFiltrados = carros;
  }


  void _filtrarCarros(String marca) {
    setState(() {
      if (marca.isEmpty) {
        carrosFiltrados = carros;
      } else {
        carrosFiltrados = carros.where((carro) => carro.marca.toLowerCase().contains(marca.toLowerCase())).toList();
      }
    });
  }


  void _adicionarAoCarrinho(Carro carro) {
    setState(() {
      carrinho.add(carro);
    });
  }


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


class TelaCarro extends StatelessWidget {
  final List<Carro> carrinho;
  final Function(Carro) onRemove;


  TelaCarro({required this.carrinho, required this.onRemove});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Seu Carrinho'),
      ),
      body: ListView.builder(
        itemCount: carrinho.length,
        itemBuilder: (context, index) {
          final carro = carrinho[index];
          return ListTile(
            title: Text('${carro.marca} ${carro.modelo}'),
            subtitle: Text('R\$${carro.preco.toStringAsFixed(2)}'),
            trailing: IconButton(
              icon: Icon(Icons.remove_shopping_cart),
              onPressed: () => onRemove(carro),
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


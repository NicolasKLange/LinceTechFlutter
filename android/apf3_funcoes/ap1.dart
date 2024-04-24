import 'package:flutter/material.dart';

const Color darkBlue = Color.fromARGB(255, 18, 32, 47);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: darkBlue,
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: Text('Cadastro Pessoa'),
          backgroundColor: darkBlue,
        ),
        body: _Formulario(),
      ),
    );
  }
}
class _Formulario extends StatefulWidget {
  @override
  State<_Formulario> createState() => _FormularioState();
}

class _FormularioState extends State<_Formulario> {
  final _formState = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _idadeController = TextEditingController();

  var _inativo = false;

  int? _idadeSalva;
  String? _nomeSalvo;
  bool? _inativoSalvo;

  bool get _isFormularioSalvo {
    return _idadeSalva != null && _nomeSalvo != null && _inativoSalvo != null;
  }

  void _enviarFormulario() {
    if (_formState.currentState!.validate()) {
      setState(() {
        _nomeSalvo = _nomeController.text;
        _idadeSalva = int.tryParse(_idadeController.text) ?? 0;
        _inativoSalvo = _inativo;
      });
    } else {
      print("Existem erros no formulário");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8),
      child: Form(
        key: _formState,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _nomeController,
                keyboardType: TextInputType.text,
                decoration: InputDecoration(
                  labelText: "Nome",
                  labelStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Nome obrigatório";
                  }
                  if (value!.length < 2) {
                    return "Nome precisa ter no mínimo duas letras";
                  }
                  if (value.startsWith(RegExp(r'[^A-Z]'))) {
                    return "Nome precisa começar com letra maiúscula";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white),
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: TextFormField(
                controller: _idadeController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: "Idade",
                  labelStyle: TextStyle(color: Colors.white),
                  border: InputBorder.none,
                ),
                validator: (value) {
                  if (value?.isEmpty ?? true) {
                    return "Idade obrigatória";
                  }
                  final idade = int.tryParse(_idadeController.text) ?? 0;
                  if (idade < 18) {
                    return "Idade inválida";
                  }
                  return null;
                },
              ),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Checkbox(
                  value: _inativo,
                  onChanged: (value) {
                    setState(() {
                      _inativo = value!;
                    });
                  },
                  fillColor: MaterialStateColor.resolveWith((states) => Colors.white),
                ),
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(_inativo ? "Inativo" : "Ativo", style: TextStyle(color: Colors.white)),
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                padding: EdgeInsets.symmetric(vertical: 15),
              ),
              child: const Text("Salvar", style: TextStyle(fontSize: 16)),
              onPressed: () {
                _enviarFormulario();
              },
            ),
            SizedBox(height: 20),
            if (_isFormularioSalvo)
              _DadosSalvos(
                idade: _idadeSalva!,
                nome: _nomeSalvo!,
                inativo: _inativoSalvo!,
              ),
          ],
        ),
      ),
    );
  }
}

class _DadosSalvos extends StatelessWidget {
  const _DadosSalvos({
    required this.idade,
    required this.nome,
    required this.inativo,
  });

  final int idade;
  final String nome;
  final bool inativo;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: inativo ? Colors.grey : Colors.green,
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text("Nome: $nome", style: TextStyle(color: Colors.white)),
          Text("Idade: $idade", style: TextStyle(color: Colors.white)),
          Text(inativo ? "Inativo" : "Ativo", style: TextStyle(color: Colors.white)),
        ],
      ),
    );
  }
}

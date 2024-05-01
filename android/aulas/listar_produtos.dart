import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/material.dart';
import 'produtos_model.dart';  //separando os arquivos
import 'detalhes_produto.dart';
void main() async {
  runApp(ListarProdutos());
}

class ListarProdutos extends StatefulWidget {
  ListarProdutos({Key? key}) : super(key: key);

  @override
  _ListarProdutosState createState() => _ListarProdutosState();
}

class _ListarProdutosState extends State<ListarProdutos> {
  ///Criando uma lista de 20 produtos usando o generate
  List<String> listaProdutos = List<String>.generate(
      20, (i) => "Produto ${i + 1}"); // Criando uma lista de produtos vazia

  Future<List<Produto>?> _getProdutos() async {
    Uri uri = Uri.parse(
        'https://api.json-generator.com/templates/VTDQS5Bt709s/data?access_token=qf0j28xiv3yup1phupiht7gwiq3711liylq5gryh');

    var response = await http.get(uri);
    var dados = json.decode(response.body) as List;

    List<Produto> produtos = [];

    dados.forEach((elemento) {
      Produto produto = Produto(
        elemento['produto_id'],
        elemento['produto'],
        elemento['endereco'],
        elemento['descricao'],
        elemento['imagem'],
        int.parse(elemento['quantidade']),
        double.parse(elemento['preco']),
      );
      produtos.add(produto);
    });
    return produtos;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Lista de produtos'),
        ),
        body: FutureBuilder(
            future: _getProdutos(),
            builder: (BuildContext context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return Center(child: Text("Carregando..."));
              } else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (context, indice) {
                    return ListTile(
                      leading: Image.network(snapshot.data[indice].imagem),
                      //colocar a imagem dos produtos
                      title: Column( //NOME PRODUTO
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text( //PRODUTO
                            "${snapshot.data[indice].produto}",
                            style: TextStyle(fontSize: 22,
                                color: Colors.blue,
                                fontWeight: FontWeight.w400),
                          ),
                          Row( //PRECO
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                "R\$" + snapshot.data[indice].preco.toString(),
                                style: TextStyle(fontSize: 20,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ],
                      ),

                      subtitle: Text(snapshot.data[indice].descricao.toString()
                          .substring(0, 30) + "..."),
                      //descricao como subtitulo, .substring(0,40) > coloca apenas os primeiros 30 caracateres
                      //colocar os produtos
                      onTap: () {
                        print(
                            "Produto: ${snapshot.data[indice]
                                .produto}, Preço: R\$${snapshot.data[indice]
                                .preco}");

                        Navigator.push(context, MaterialPageRoute(builder: (
                            context) {
                          return DetalhesProduto( //LISTAR OS DETALHES DO PRODUTO NA OUTRA TELA
                            produto_id: snapshot.data[indice].produto_id,
                            produto: snapshot.data[indice].produto,
                            descricao: snapshot.data[indice].descricao,
                            imagem: snapshot.data[indice].imagem,
                            preco: snapshot.data[indice].preco,
                          );
                        }));
                      },
                    );
                  },
                );
              }
            }),
      ),
    );
  }
}



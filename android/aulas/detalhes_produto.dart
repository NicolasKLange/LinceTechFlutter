import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DetalhesProduto extends StatefulWidget {
  final String? produto_id;
  final String? produto;
  final String? descricao;
  final double? preco;
  final String? imagem;

  const DetalhesProduto(
      {super.key,
        this.produto_id,
        this.produto,
        this.descricao,
        this.preco,
        this.imagem});

  @override
  State<DetalhesProduto> createState() => _DetalhesProdutoState();
}

class _DetalhesProdutoState extends State<DetalhesProduto> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(widget.produto_id.toString(), style: TextStyle(color: Colors.white),),
          backgroundColor: Colors.purple,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.center,
              children:[
                Image.network(
                  widget.imagem.toString(),
                  fit: BoxFit.fill,
                  width: double.infinity,
                ),
                Text( //PRODUTO
                  widget.produto.toString(),
                  style: TextStyle(
                    fontSize: 30,
                    color: Colors.blue,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text( //DESCRICAO
                  widget.descricao.toString(),
                  style: TextStyle(fontSize: 15),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text( //PRECO
                      "R\$" + widget.preco.toString(),
                      style: TextStyle(
                        fontSize: 30,
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                ElevatedButton(
                  child: Text("Retornar para os produtos", style: TextStyle(fontSize: 20, color: Colors.purple),),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

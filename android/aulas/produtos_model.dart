///CLASSE PARA GERENCIAR OS ELEMENTOS
class Produtos {
  final List produtos;

  Produtos(this.produtos);
}

class Produto {
  final String produto_id;
  final String produto;
  final String endereco;
  final String descricao;
  final String imagem;
  final int    quantidade;
  final double preco;

  Produto(this.produto_id, this.produto, this.endereco, this.descricao,
      this.imagem, this.quantidade, this.preco);

  //FACTORY INICIALIZAOU A CLASSE COM OS DADOS
  factory Produto.fromJson(Map<String, dynamic> json) {
    return Produto(json['produto_id'], json['produto'], json['endereco'],
        json['descricao'], json['imagem'], json['quantidade'], json['preco']);
  }

  ///MAPEAMENTO DA ESTRUTURA DO JSON
  Map<String, dynamic> toJson() => {
    'produto_id': this.produto_id,
    'produto': this.produto,
    'endereco': this.endereco,
    'descricao': this.descricao,
    'imagem': this.imagem,
    'quantidade': this.quantidade,
    'preco': this.preco,
  };
}
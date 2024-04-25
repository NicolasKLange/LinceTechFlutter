import 'dart:async';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() async {
  Uri uri = Uri.https('jsonplaceholder.typicode.com', '/todos/1');
  final future = http.get(uri);
  future.then((response) {
    if (response.statusCode == 200) {
      print("Pagina carregada com sucesso!!");
      print(json.decode(response.body));

      //TRANSFORMANDO OS DADOS JSON EM VARIAVEIS PARA APENAS UM ELEMENTO
      Map<String, dynamic> dados = json.decode(response.body);
      //print(dados);

      ///MAPEAR OS DADOS RECEBIDOS DO JSON
      /*
      Todo todo = Todo(
          dados['userId'], dados['id'], dados['title'], dados['completed']);
      */

      Todo todo = Todo.fromJson(dados);
      print("Json modificado ${todo.toJson()}");
      print("Titulo: ${todo.title}");
      //print(dados['id']);

      ///USANDO VARIAS VALORES, LISTAS GRANDES
      /*
      var list = json.decode(response.body) as List;

      list.forEach((element) {
        //BUSCANDO APENAS O ID
        print(element['id']);
      });
      */
    } else {
      print("ERRO!!");
    }
  });
}

///CLASSE PARA GERENCIAR OS ELEMENTOS
class Todo {
  final int userId;
  final int id;
  final String title;
  final bool completed;

  Todo(this.userId, this.id, this.title, this.completed);

  //FACTORY INICIALIZAOU A CLASSE COM OS DADOS
  factory Todo.fromJson( Map json) {
    return Todo(
        json['userId'], json['id'], json['title'], json['completed']);

  }

  ///MAPEAMENTO DA ESTRUTURA DO JSON
  Map<String, dynamic> toJson() => {
    'userId' : this.userId,
    //'id' : this.id,  //da para modificar a estrutura
    'title' : this.title,
    'completed' : this.completed,
  };
}

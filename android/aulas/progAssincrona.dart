import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'dart:async';

void main() {
  //VARIAVEL PARA A URL DO APP
  final uri = Uri.https('www.example.com', '/', {'q' : 'flutter'}); //colocando parametros de busca na url
  final future = http.get(uri);
  print(uri);
 //FAZENDO OS PRINCIPAIS TRATAMENTOS DE RESPOSTA COM O APP, CONTROLE DE ERROS DA REQUISICAO HTTPS
 future.then((response) {
   if(response.statusCode == 200) {
     print("Pagina carregada com sucesso!!");
   }
   if(response.statusCode == 301) {
    print("Pagina movida permanentemente!!");
   }
   if(response.statusCode == 404) {
    print("Pagina nao encontrada!!");
   }
   if(response.statusCode == 500) {
    print("Erro interno no servidor!!");
   }
 });
 //TRATAMENTO COM catchError
 future.catchError((onError) => print("Erro"));
 //TRATAMENTO COM whenComplete
 future.whenComplete(() => print("Future completo"));
}


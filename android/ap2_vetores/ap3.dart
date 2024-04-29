import 'dart:io';
import 'dart:math';

void main() {
  print('Digite o tamanho do vetor:');
  int tamanho = int.parse(stdin.readLineSync()!);

  List<int> v1 = [];
  List<int> v2 = [];
  List<int> v3 = [];

  // Solicita ao usuário os valores para o vetor v1
  for (int i = 0; i < tamanho; i++) {
    print('Digite o valor para a posição ${i + 1} do vetor v1:');
    int valor = int.parse(stdin.readLineSync()!);
    v1.add(valor);
  }

  // Gera o vetor v2 com números aleatórios
  Random random = Random();
  for (int i = 0; i < tamanho; i++) {
    v2.add(random.nextInt(100)); // Gerando números aleatórios entre 0 e 99
  }

  // Calcula o vetor v3 como a soma dos vetores v1 e v2
  for (int i = 0; i < tamanho; i++) {
    v3.add(v1[i] + v2[i]);
  }

  // Imprime os vetores no terminal
  print('Vetor v1: $v1');
  print('Vetor v2: $v2');
  print('Vetor v3 (soma de v1 e v2): $v3');
}
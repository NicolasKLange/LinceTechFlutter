import 'dart:io';

void main() {
  print('Digite o tamanho do vetor:');
  int tamanho = int.parse(stdin.readLineSync()!);

  List<int> vetor = [];

  // Solicita ao usuário que insira os números para alimentar o vetor
  for (int i = 0; i < tamanho; i++) {
    print('Digite o elemento ${i + 1}:');
    int elemento = int.parse(stdin.readLineSync()!);
    vetor.add(elemento);
  }

  // Imprime o vetor no terminal
  print('Vetor:');
  print(vetor);
}
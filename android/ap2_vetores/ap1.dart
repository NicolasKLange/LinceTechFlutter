import 'dart:io';
import 'dart:math';

void main() {
  print('Digite o tamanho do vetor:');
  int tamanho = int.parse(stdin.readLineSync()!);

  List<int> vetor = gerarVetorAleatorio(tamanho);

  print('Vetor gerado:');
  print(vetor);
}

List<int> gerarVetorAleatorio(int tamanho) {
  Random random = Random();
  List<int> vetor = [];

  for (int i = 0; i < tamanho; i++) {
    vetor.add(random.nextInt(100)); // Gerando números aleatórios entre 0 e 99
  }

  return vetor;
}
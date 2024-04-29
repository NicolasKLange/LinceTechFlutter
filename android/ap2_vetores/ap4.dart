import 'dart:io';
import 'dart:math';

void main() {
  int escolha;
  do {
    print('Escolha uma opção:');
    print('1. Gerar vetor de números aleatórios');
    print('2. Criar vetor com valores informados pelo usuário');
    print('3. Gerar vetores e calcular a soma');
    print('0. Sair');

    escolha = int.parse(stdin.readLineSync()!);

    switch (escolha) {
      case 1:
        gerarVetorAleatorio();
        break;
      case 2:
        criarVetorUsuario();
        break;
      case 3:
        calcularSomaVetores();
        break;
      case 0:
        print('Saindo do programa.');
        break;
      default:
        print('Opção inválida. Tente novamente.');
        break;
    }
  } while (escolha != 0);
}

void gerarVetorAleatorio() {
  print('Digite o tamanho do vetor:');
  int tamanho = int.parse(stdin.readLineSync()!);

  List<int> vetor = [];

  Random random = Random();
  for (int i = 0; i < tamanho; i++) {
    vetor.add(random.nextInt(100)); // Gerando números aleatórios entre 0 e 99
  }

  print('Vetor gerado:');
  print(vetor);
}

void criarVetorUsuario() {
  print('Digite o tamanho do vetor:');
  int tamanho = int.parse(stdin.readLineSync()!);

  List<int> vetor = [];

  for (int i = 0; i < tamanho; i++) {
    print('Digite o elemento ${i + 1}:');
    int elemento = int.parse(stdin.readLineSync()!);
    vetor.add(elemento);
  }

  print('Vetor:');
  print(vetor);
}

void calcularSomaVetores() {
  print('Digite o tamanho do vetor:');
  int tamanho = int.parse(stdin.readLineSync()!);

  List<int> v1 = [];
  List<int> v2 = [];
  List<int> v3 = [];

  for (int i = 0; i < tamanho; i++) {
    print('Digite o valor para a posição ${i + 1} do vetor v1:');
    int valor = int.parse(stdin.readLineSync()!);
    v1.add(valor);
  }

  Random random = Random();
  for (int i = 0; i < tamanho; i++) {
    v2.add(random.nextInt(100)); // Gerando números aleatórios entre 0 e 99
  }

  for (int i = 0; i < tamanho; i++) {
    v3.add(v1[i] + v2[i]);
  }

  print('Vetor v1: $v1');
  print('Vetor v2: $v2');
  print('Vetor v3 (soma de v1 e v2): $v3');
}
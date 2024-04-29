import 'dart:io';

void main() {
  print('Digite o número de linhas da primeira matriz:');
  int linhas1 = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da primeira matriz:');
  int colunas1 = int.parse(stdin.readLineSync()!);

  List<List<double>> matriz1 = criarMatrizUsuario(linhas1, colunas1);

  print('Digite o número de linhas da segunda matriz:');
  int linhas2 = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da segunda matriz:');
  int colunas2 = int.parse(stdin.readLineSync()!);

  List<List<double>> matriz2 = criarMatrizUsuario(linhas2, colunas2);

  if (colunas1 != linhas2) {
    print('Não é possível multiplicar as matrizes. O número de colunas da primeira matriz não é igual ao número de linhas da segunda matriz.');
    return;
  }

  List<List<double>> matrizProduto = multiplicarMatrizes(matriz1, matriz2);

  print('Matriz 1:');
  imprimirMatriz(matriz1);

  print('Matriz 2:');
  imprimirMatriz(matriz2);

  print('Matriz Produto:');
  imprimirMatriz(matrizProduto);
}

List<List<double>> criarMatrizUsuario(int linhas, int colunas) {
  List<List<double>> matriz = [];

  for (int i = 0; i < linhas; i++) {
    List<double> linha = [];
    for (int j = 0; j < colunas; j++) {
      print('Digite o valor para a posição ($i, $j):');
      double valor = double.parse(stdin.readLineSync()!);
      linha.add(valor);
    }
    matriz.add(linha);
  }

  return matriz;
}

void imprimirMatriz(List<List<double>> matriz) {
  for (int i = 0; i < matriz.length; i++) {
    print(matriz[i]);
  }
}

List<List<double>> multiplicarMatrizes(List<List<double>> matriz1, List<List<double>> matriz2) {
  int linhas1 = matriz1.length;
  int colunas1 = matriz1[0].length;
  int colunas2 = matriz2[0].length;

  List<List<double>> matrizProduto = [];

  for (int i = 0; i < linhas1; i++) {
    List<double> linha = [];
    for (int j = 0; j < colunas2; j++) {
      double soma = 0;
      for (int k = 0; k < colunas1; k++) {
        soma += matriz1[i][k] * matriz2[k][j];
      }
      linha.add(soma);
    }
    matrizProduto.add(linha);
  }

  return matrizProduto;
}

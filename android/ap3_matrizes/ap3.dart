import 'dart:io';

void main() {
  print('Digite o número de linhas da matriz:');
  int linhas = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da matriz:');
  int colunas = int.parse(stdin.readLineSync()!);

  List<List<double>> matriz = criarMatrizUsuario(linhas, colunas);

  print('Matriz informada pelo usuário:');
  imprimirMatriz(matriz);

  print('Digite um número real para multiplicar a matriz:');
  double multiplicador = double.parse(stdin.readLineSync()!);

  List<List<double>> matrizMultiplicada = multiplicarMatriz(matriz, multiplicador);

  print('Matriz original:');
  imprimirMatriz(matriz);

  print('Matriz multiplicada pelo número $multiplicador:');
  imprimirMatriz(matrizMultiplicada);
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

List<List<double>> multiplicarMatriz(List<List<double>> matriz, double multiplicador) {
  List<List<double>> matrizResultante = [];

  for (int i = 0; i < matriz.length; i++) {
    List<double> linha = [];
    for (int j = 0; j < matriz[i].length; j++) {
      linha.add(matriz[i][j] * multiplicador);
    }
    matrizResultante.add(linha);
  }

  return matrizResultante;
}
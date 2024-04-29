import 'dart:io';

void main() {
  print('Digite o número de linhas da matriz:');
  int linhas = int.parse(stdin.readLineSync()!);

  print('Digite o número de colunas da matriz:');
  int colunas = int.parse(stdin.readLineSync()!);

  List<List<int>> matriz = criarMatrizUsuario(linhas, colunas);

  print('Matriz gerada:');
  imprimirMatriz(matriz);
}

List<List<int>> criarMatrizUsuario(int linhas, int colunas) {
  List<List<int>> matriz = [];

  for (int i = 0; i < linhas; i++) {
    List<int> linha = [];
    for (int j = 0; j < colunas; j++) {
      print('Digite o valor para a posição ($i, $j):');
      int valor = int.parse(stdin.readLineSync()!);
      linha.add(valor);
    }
    matriz.add(linha);
  }

  return matriz;
}

void imprimirMatriz(List<List<int>> matriz) {
  for (int i = 0; i < matriz.length; i++) {
    print(matriz[i]);
  }
}
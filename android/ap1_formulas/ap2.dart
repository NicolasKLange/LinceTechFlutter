import 'dart:io';

void main() {
  // Solicita ao usuário que insira um número decimal
  print('Insira um número decimal:');
  int numeroDecimal = int.parse(stdin.readLineSync()!);

  // Converte o número decimal para binário, octal e hexadecimal
  String binario = numeroDecimal.toRadixString(2);
  String octal = numeroDecimal.toRadixString(8);
  String hexadecimal = numeroDecimal.toRadixString(16).toUpperCase();

  // Exibe os resultados
  print('Em binário: $binario');
  print('Em octal: $octal');
  print('Em hexadecimal: $hexadecimal');
}
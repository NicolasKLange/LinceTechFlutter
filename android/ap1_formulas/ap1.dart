import 'dart:io';
import 'dart:math';

void main() {
  // Solicita ao usuário que insira os comprimentos dos dois catetos
  print('Insira o comprimento do primeiro cateto:');
  double cateto1 = double.parse(stdin.readLineSync()!);

  print('Insira o comprimento do segundo cateto:');
  double cateto2 = double.parse(stdin.readLineSync()!);

  // Calcula a hipotenusa usando o teorema de Pitágoras
  double hipotenusa = sqrt((cateto1*cateto1) + (cateto2*cateto2)) ;

  // Exibe o resultado
  print('A hipotenusa é: $hipotenusa');
}
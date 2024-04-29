import 'dart:io';
import 'dart:math';

void main() {
  int escolha;
  do {
    print('Escolha uma opção:');
    print('1. Calcular dimensão do maior lado de um triângulo retângulo');
    print('2. Converter número decimal para binário, octal e hexadecimal');
    print('3. Resolver equação quadrática usando a fórmula de Bhaskara');
    print('0. Sair');

    escolha = int.parse(stdin.readLineSync()!);

    switch (escolha) {
      case 1:
        calcularTrianguloRetangulo();
        break;
      case 2:
        converterBase();
        break;
      case 3:
        calcularBhaskara();
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

void calcularTrianguloRetangulo() {
  print('Insira o comprimento do primeiro cateto:');
  double cateto1 = double.parse(stdin.readLineSync()!);

  print('Insira o comprimento do segundo cateto:');
  double cateto2 = double.parse(stdin.readLineSync()!);

  double hipotenusa = sqrt((cateto1*cateto1) + (cateto2*cateto2));

  print('A hipotenusa é: $hipotenusa');
}

void converterBase() {
  print('Insira um número decimal:');
  int numeroDecimal = int.parse(stdin.readLineSync()!);

  String binario = numeroDecimal.toRadixString(2);
  String octal = numeroDecimal.toRadixString(8);
  String hexadecimal = numeroDecimal.toRadixString(16).toUpperCase();

  print('Em binário: $binario');
  print('Em octal: $octal');
  print('Em hexadecimal: $hexadecimal');
}

void calcularBhaskara() {
  print('Insira o coeficiente "a":');
  double a = double.parse(stdin.readLineSync()!);

  print('Insira o coeficiente "b":');
  double b = double.parse(stdin.readLineSync()!);

  print('Insira o coeficiente "c":');
  double c = double.parse(stdin.readLineSync()!);

  double discriminante = (b*b) - 4 * a * c;

  if (discriminante < 0) {
    print('A equação não possui raízes reais.');
  } else {
    double raiz1 = (-b + sqrt(discriminante)) / (2 * a);
    double raiz2 = (-b - sqrt(discriminante)) / (2 * a);

    print('As raízes da equação são:');
    print('Raiz 1: $raiz1');
    print('Raiz 2: $raiz2');
  }
}
import 'dart:io';
import 'dart:math';

void main() {
  // Solicita ao usuário que insira os coeficientes da equação quadrática
  print('Insira o coeficiente "a":');
  double a = double.parse(stdin.readLineSync()!);

  print('Insira o coeficiente "b":');
  double b = double.parse(stdin.readLineSync()!);

  print('Insira o coeficiente "c":');
  double c = double.parse(stdin.readLineSync()!);

  // Calcula o discriminante
  double discriminante = (b*b) - 4 * a * c;

  // Verifica se o discriminante é negativo
  if (discriminante < 0) {
    print('A equação não possui raízes reais.');
  } else {
    // Calcula as raízes
    double raiz1 = (-b + sqrt(discriminante)) / (2 * a);
    double raiz2 = (-b - sqrt(discriminante)) / (2 * a);

    // Exibe as raízes
    print('As raízes da equação são:');
    print('Raiz 1: $raiz1');
    print('Raiz 2: $raiz2');
  }
}
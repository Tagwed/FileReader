import 'dart:io';
import 'dart:math';

void main() {
  File file = File('input.txt');
  List<String> dannie = file.readAsLinesSync();

  stdout.write(
      'Что вы хотите сделать?\nЕсли показать список - нажмите y\nЕсли выйти - нажмите - q\n');

  while (true) {
    String? input = stdin.readLineSync();
    switch (input!) {
      case 'y':
        for (int i = 0; i < dannie.length; i++) {
          List<String> dannieSplit = dannie[i].split('|');
          String purchase = dannieSplit[0];
          int money = int.parse(dannieSplit[1]);
          String category = dannieSplit[2];
          DateTime date = DateTime.parse(dannieSplit[3]);
          print('$purchase $money $category $date');
        }
      case 'q':
        print('Bye, bye');
      default:
        stdout.write('Вы ввели некорректное значение, введите другое\n');
        continue;
    }
    break;
  }
}

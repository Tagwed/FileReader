import 'dart:io';
import 'dart:math';

void main() {
  File file = File('input.txt');
  List<String> dannie = file.readAsLinesSync();
  bool state = true;
  while (state) {
     stdout.write('''Что вы хотите сделать?
Показать список - нажмите y
Новая запись - нажмите n
Выйти - нажмите q
Посчитать сальдо - введите s\n''');
    String? input = stdin.readLineSync();
    switch (input!) {
      case 's' :
        print('Введите год:\n');
        String? year = stdin.readLineSync();
        print('Введите месяц:\n');
        String? month = stdin.readLineSync();
        int? yearParse = int.tryParse(year!);
        int? monthParse = int.tryParse(month!);
        int result = 0;
        for (int i = 0; i < dannie.length; i++) {
          List<String> dannieSplit = dannie[i].split('|');
          String purchase = dannieSplit[0];
          int money = int.parse(dannieSplit[1]);
          String category = dannieSplit[2];
          DateTime date = DateTime.parse(dannieSplit[3]);
          if (yearParse == date.year && monthParse == date.month){
            result += money;
          }
        }
        print('Ваше сальдо = $result');

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
        state = false;
        continue;

      case 'n':
        print('Введите название действия:\n');
        String? dealName = stdin.readLineSync();

        print('Введите сумму дохода(+)/ или расхода(-):\n');
        int? sum;
        while (true) {
          String operationInput = stdin.readLineSync() ?? '';
          int? sum1 = int.tryParse(operationInput);
          if (sum1 == null) {
            print('Введите цифры');
          } else {
            sum = sum1;
            break;
          }
        }

        print('Введите категорию операции:\n');
        String? operationCategory = stdin.readLineSync();

        print('Введите дату в формате ГГГГ-ММ-ДД:\n');
        DateTime? time;
        while (true) {
          String dateInput = stdin.readLineSync() ?? '';
          DateTime? dateTime = DateTime.tryParse(dateInput);
          if (dateTime == null) {
            print('Введите дату');
          } else {
            time = dateTime;
            break;
          }
        }
        String month = '';
        if (time.month <= 9){
          month = '0${time.month}';
        } else {
          month = time.month.toString();
        }

        file.writeAsStringSync(
            '\n$dealName|$sum|$operationCategory|${time.year}-$month-${time.day}',
            mode: FileMode.append);

      default:
        stdout.write('Вы ввели некорректное значение, введите другое\n');
        continue;
    }
  }
}

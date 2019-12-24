import 'package:date_format/date_format.dart';
import 'package:flutter_masked_text/flutter_masked_text.dart';

class Helper {
  static List<String> months = [
    'Janeiro',
    'Fevereiro',
    'Março',
    'Abril',
    'Maio',
    'Junho',
    'Julho',
    'Agosto',
    'Setembro',
    'Outubro',
    'Novembro',
    'Dezembro'
  ];

  static List<String> week = [
    'Segunda',
    'Terça-feira',
    'Quarta-feira',
    'Quinta-feira',
    'Sexta-feira',
    'Sabado',
    'Domingo'
  ];

  static String formatPhone(String value) {
    if (value.isEmpty || value == null || value.length == 0) {
      return "";
    }

    final mask = MaskedTextController(
        text: value,
        mask: value.length > 10 ? '(00) 00000-0000' : '(00) 0000-0000');

    return mask.text;
  }

  static String formatMoney(dynamic value, {bool leftStr = true}) {
    final controller = new MoneyMaskedTextController(
        leftSymbol: leftStr ? value < 0 ? 'R\$ -' : 'R\$ ' : '');
    controller.updateValue(toDouble(value));
    return controller.text;
  }

  static String formatForDecimal(int value) {
    final controller = new MoneyMaskedTextController(
      precision: 0,
    );
    controller.updateValue(toDouble(value));

    return controller.text.replaceAll(',', '');
  }

  static String formatFromDateStr(String value, [bool hours]) {
    return value != '' && value != null
        ? formatFromDate(DateTime.parse(value), hours)
        : '00/00/0000';
  }

  static String formatFromDateNow([bool hours]) {
    return formatFromDate(DateTime.now(), hours);
  }

  static String formatFromDate(DateTime data, [bool hours]) {
    if (data == null) {
      return '00/00/0000';
    }
    return hours == null || hours == false
        ? formatDate(data, [dd, '/', mm, '/', yyyy])
        : formatDate(data, [dd, '/', mm, '/', yyyy, ' ', HH, ':', nn]);
  }

  static String formatDateWeekName(DateTime data,
      [String separator = '-', bool year = false]) {
    if (data == null) {
      return '00/00/0000';
    }
    String res = "";
    res += data.day < 10 ? "0${data.day}" : "${data.day}";
    res += "$separator";
    res += "${months[data.month]}".substring(0, 3);
    res += year ? "$separator${data.year}" : "";

    return res;
  }

  static String getHoursFromDate(DateTime data, [bool seconds]) {
    if (data == null) {
      return '00:00';
    }
    return seconds != null && seconds == true
        ? formatDate(data, [HH, ':', nn, ':', ss])
        : formatDate(data, [HH, ':', nn]);
  }

  static String formatDateForUs(DateTime data) {
    return "${data.year.toString().padLeft(4, '0')}-${data.month.toString().padLeft(2, '0')}-${data.day.toString().padLeft(2, '0')}";
  }

  static double toDouble(value) {
    return value + .0;
  }
}

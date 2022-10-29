import 'package:intl/intl.dart';

class DateTimeUtils {
  DateTimeUtils._();

  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime tomorrow() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1);
  }
}

extension DateTimeExt on DateTime {
  DateTime get date => DateTime(year, month, day);

  String formatDate() {
    return DateFormat('dd.MM.yyyy').format(this);
  }

  bool isToday() => this == DateTimeUtils.today();
}

import 'package:intl/intl.dart';

class DateTimeUtils {
  static DateTime today() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }

  static DateTime tomorrow() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day + 1);
  }

  static String formatDate(DateTime date) {
    return DateFormat('dd.MM.yyyy').format(date);
  }
}

extension DateTimeExtension on DateTime {
  DateTime get date => DateTime(year, month, day);

  bool isToday() => date == DateTimeUtils.today();

  bool isTomorrow() => date == DateTimeUtils.tomorrow();

  bool inThisWeek() {
    final today = DateTimeUtils.today();
    final weekDay = today.weekday;
    final firstDayOfWeek = today.subtract(Duration(days: weekDay));
    return date.isAfter(firstDayOfWeek) &&
        date.isBefore(firstDayOfWeek.add(const Duration(days: 7)));
  }
}

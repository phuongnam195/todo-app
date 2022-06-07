import 'package:todo_app/generated/l10n.dart';

enum RepeatType { never, day, week, month, year }

extension ParseToString on RepeatType {
  String string() {
    switch (this) {
      case RepeatType.never:
        return S.current.never;
      case RepeatType.day:
        return S.current.every_day;
      case RepeatType.week:
        return S.current.every_week;
      case RepeatType.month:
        return S.current.every_month;
      case RepeatType.year:
        return S.current.every_year;
      default:
        return '';
    }
  }

  DateTime? nextDate(DateTime curr) {
    switch (this) {
      case RepeatType.day:
        return DateTime(curr.year, curr.month, curr.day + 1);
      case RepeatType.week:
        return DateTime(curr.year, curr.month, curr.day + 7);
      case RepeatType.month:
        return DateTime(curr.year, curr.month + 1, curr.day);
      case RepeatType.year:
        return DateTime(curr.year + 1, curr.month, curr.day);
      default:
        return null;
    }
  }
}

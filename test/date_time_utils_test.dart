import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/util/date_time_utils.dart';

void main() {
  test('DateTimeExtension -> inThisWeek 1', () {
    var now = DateTime.now();
    expect(now.inThisWeek(), true);
  });

  test('DateTimeExtension -> inThisWeek 2', () {
    var now = DateTime.now();
    var weekday = now.weekday;
    var date = now.subtract(Duration(days: weekday - 1));

    expect(date.inThisWeek(), true);
  });

  test('DateTimeExtension -> inThisWeek 3', () {
    var now = DateTime.now();
    var weekday = now.weekday;
    var date = now.subtract(Duration(days: weekday));

    expect(date.inThisWeek(), false);
  });
}

import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/model/repeat_type.dart';

void main() {
  test('ParseToString -> nextDate 1', () {
    var repeatType = RepeatType.day;
    var date = DateTime(2022, 2, 28);
    expect(repeatType.nextDate(date), DateTime(2022, 3, 1));
  });

  test('ParseToString -> nextDate 2', () {
    var repeatType = RepeatType.month;
    var date = DateTime(2022, 12, 30);
    expect(repeatType.nextDate(date), DateTime(2023, 1, 30));
  });
}

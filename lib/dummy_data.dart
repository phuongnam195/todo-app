import 'package:todo_app/model/repeat_type.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/util/date_time_utils.dart';

List<Task> DUMMY_TASKS = [
  Task(
    id: 1,
    title: 'Buy milk',
    isCompleted: false,
    createdDate: DateTime.now(),
    dueDate: DateTimeUtils.tomorrow(),
  ),
  Task(
    id: 2,
    title: 'Sell shirt',
    isCompleted: true,
    createdDate: DateTime.now(),
    dueDate: DateTimeUtils.tomorrow(),
    completedDate: DateTime.now().subtract(const Duration(hours: 13)),
    repeatType: RepeatType.month,
  ),
  Task(
    id: 3,
    title: 'Go to gym',
    createdDate: DateTime.now(),
    dueDate: DateTimeUtils.tomorrow(),
    repeatType: RepeatType.year,
  ),
  Task(
    id: 4,
    title: 'Hang out with friends',
    createdDate: DateTime.now(),
    dueDate: DateTimeUtils.tomorrow(),
  ),
];

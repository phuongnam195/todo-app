import 'package:todo_app/database/task_database.dart';
import 'package:todo_app/model/task.dart';
import 'package:todo_app/util/date_time_utils.dart';

abstract class ITaskRepository {
  Future<void> init();
  Future<List<Task>> getAll();
  Future<List<Task>> getCompletedTasks();
  Future<List<Task>> getIncompletedTasks();
  Future<List<Task>> getTodayTasks();
  Future<Task?> getById(int id);
  Future<bool> addTask(Task task);
  Future<bool> updateTask(Task task);
  Future<bool> deleteTask(int id);
}

class TaskRepository implements ITaskRepository {
  static final TaskRepository _singleton = TaskRepository._internal();
  factory TaskRepository() {
    return _singleton;
  }
  TaskRepository._internal();

  final TaskDatabase _appDB = TaskDatabase();

  @override
  Future<void> init() async {
    await _appDB.open();
  }

  @override
  Future<bool> addTask(Task task) async {
    // task = task.copyWith(
    //     id: DateTime.now().millisecondsSinceEpoch % 100,
    //     completedDate: task.completedDate);
    // DUMMY_TASKS.add(task);
    // return true;

    return (await _appDB.insert(task)) != null;
  }

  @override
  Future<bool> deleteTask(int id) async {
    // int oldCount = DUMMY_TASKS.length;
    // DUMMY_TASKS.removeWhere((task) => task.id == id);
    // return DUMMY_TASKS.length != oldCount;

    return (await _appDB.delete(id)) == 1;
  }

  @override
  Future<List<Task>> getAll() async {
    // return DUMMY_TASKS;
    return await _appDB.getList();
  }

  @override
  Future<List<Task>> getCompletedTasks() async {
    // return DUMMY_TASKS.where((e) => e.isCompleted == true).toList();
    return await _appDB.getList(completed: true);
  }

  @override
  Future<List<Task>> getIncompletedTasks() async {
    // return DUMMY_TASKS.where((e) => e.isCompleted == false).toList();
    return await _appDB.getList(completed: false);
  }

  @override
  Future<List<Task>> getTodayTasks() async {
    // return DUMMY_TASKS.where((e) => e.dueDate.isToday()).toList();

    return await _appDB.getList(
      where: '$columnDueDate = ?',
      whereArgs: [DateTimeUtils.today().toIso8601String()],
    );
  }

  @override
  Future<Task?> getById(int id) async {
    // return DUMMY_TASKS.firstWhere((e) => e.id == id);

    return await _appDB.get(id);
  }

  @override
  Future<bool> updateTask(Task task) async {
    // int index = DUMMY_TASKS.indexWhere((e) => e.id == task.id);
    // DUMMY_TASKS[index] = task;
    // return true;

    return (await _appDB.update(task)) == 1;
  }
}

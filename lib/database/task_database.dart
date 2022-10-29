import 'package:sqflite/sqflite.dart';
import 'package:todo_app/model/task.dart';

const tableTask = 'task';
const columnId = 'id';
const columnTitle = 'title';
const columnIsCompleted = 'isCompleted';
const columnCreatedDate = 'createdDate';
const columnDueDate = 'dueDate';
const columnCompletedDate = 'completedDate';
const columnRepeatType = 'repeatType';

class TaskDatabase {
  static const _name = 'todo_app.db';
  static late final Database _db;

  Future open() async {
    _db = await openDatabase(_name, version: 1, onCreate: (db, version) async {
      await db.execute('''
create table $tableTask (
  $columnId integer primary key autoincrement, 
  $columnTitle text not null,
  $columnIsCompleted integer not null,
  $columnCreatedDate text not null,
  $columnDueDate text,
  $columnCompletedDate text,
  $columnRepeatType text not null)
''');
    });
  }

  Future<Task?> insert(Task task) async {
    final maps = await _db.query(tableTask,
        columns: [columnId, columnTitle, columnDueDate, columnRepeatType],
        where:
            '$columnTitle = ? and $columnDueDate = ? and $columnRepeatType = ?',
        whereArgs: [
          task.title,
          task.dueDate.toIso8601String(),
          task.repeatType.name
        ]);

    if (maps.isNotEmpty) return null;

    int id = await _db.insert(
        tableTask, task.toJson()..update('isCompleted', (val) => val ? 1 : 0));
    if (id == 0) return null;

    return task.copyWith(id: id, completedDate: task.completedDate);
  }

  Future<Task?> get(int id) async {
    List<Map<String, dynamic>> maps = await _db.query(tableTask,
        columns: [
          columnId,
          columnTitle,
          columnIsCompleted,
          columnCreatedDate,
          columnDueDate,
          columnCompletedDate,
          columnRepeatType
        ],
        where: '$columnId = ?',
        whereArgs: [id]);
    if (maps.isNotEmpty) {
      Map<String, dynamic> writeMap = Map.from(maps.first);
      return Task.fromJson(writeMap..update('isCompleted', (val) => val == 1));
    }
    return null;
  }

  Future<List<Task>> getList(
      {bool? completed, String? where, List<Object?>? whereArgs}) async {
    List<Map<String, dynamic>> maps = await _db.query(
      tableTask,
      columns: [
        columnId,
        columnTitle,
        columnIsCompleted,
        columnCreatedDate,
        columnDueDate,
        columnCompletedDate,
        columnRepeatType
      ],
      where: where ?? (completed != null ? '$columnIsCompleted = ?' : null),
      whereArgs: whereArgs ?? (completed != null ? [completed ? 1 : 0] : null),
    );

    return maps.map((map) {
      Map<String, dynamic> writeMap = Map.from(map);
      return Task.fromJson(writeMap..update('isCompleted', (val) => val == 1));
    }).toList();
  }

  Future<int> delete(int id) async {
    return await _db.delete(tableTask, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Task task) async {
    return await _db.update(
        tableTask, task.toJson()..update('isCompleted', (val) => val ? 1 : 0),
        where: '$columnId = ?', whereArgs: [task.id]);
  }

  Future close() async => _db.close();
}

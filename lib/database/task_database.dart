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
  $columnCreatedDate integer not null,
  $columnDueDate integer,
  $columnCompletedDate integer,
  $columnRepeatType text not null)
''');
    });
  }

  Future<Task?> insert(Task task) async {
    final maps = await _db.query(tableTask,
        columns: [columnId, columnTitle, columnDueDate, columnRepeatType],
        where: '$columnTitle = ?, $columnDueDate = ?, $columnRepeatType = ?',
        whereArgs: [task.title, task.dueDate, task.repeatType]);

    if (maps.isNotEmpty) return null;

    int id = await _db.insert(tableTask, task.toJson());
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
      return Task.fromJson(maps.first);
    }
    return null;
  }

  Future<List<Task>> getList([bool? completed]) async {
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
      where: completed != null ? '$columnIsCompleted = ?' : null,
      whereArgs: completed != null ? [completed] : null,
    );
    return maps.map((e) => Task.fromJson(e)).toList();
  }

  Future<int> delete(int id) async {
    return await _db.delete(tableTask, where: '$columnId = ?', whereArgs: [id]);
  }

  Future<int> update(Task task) async {
    return await _db.update(tableTask, task.toJson(),
        where: '$columnId = ?', whereArgs: [task.id]);
  }

  Future close() async => _db.close();
}

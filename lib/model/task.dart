import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/util/date_time_utils.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final int id;
  final String title;
  final bool isCompleted;
  final DateTime createdDate;
  final DateTime dateTime;
  final DateTime? completedDate;

  const Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdDate,
    required this.dateTime,
    this.completedDate,
  }) : assert(isCompleted ^ (completedDate == null));

  bool get isOverdue =>
      completedDate == null && dateTime.isBefore(DateTimeUtils.today());

  Task copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? createdDate,
    DateTime? dateTime,
    required DateTime? completedDate,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdDate: createdDate ?? this.createdDate,
      dateTime: dateTime ?? this.dateTime,
      completedDate: completedDate,
    );
  }

  Task complete() {
    return copyWith(
      isCompleted: true,
      completedDate: DateTime.now(),
    );
  }

  Task uncomplete() {
    return copyWith(
      isCompleted: false,
      completedDate: null,
    );
  }

  factory Task.fromJson(Map<String, dynamic> json) => _$TaskFromJson(json);

  Map<String, dynamic> toJson() => _$TaskToJson(this);

  @override
  List<Object?> get props =>
      [id, title, isCompleted, createdDate, dateTime, completedDate];

  @override
  bool get stringify => true;
}

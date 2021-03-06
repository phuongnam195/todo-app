import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:todo_app/util/date_time_utils.dart';

import 'repeat_type.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final int id;
  final String title;
  final bool isCompleted;
  final DateTime createdDate;
  final DateTime dueDate;
  final DateTime? completedDate;
  final RepeatType repeatType;

  const Task({
    required this.id,
    required this.title,
    this.isCompleted = false,
    required this.createdDate,
    required this.dueDate,
    this.completedDate,
    this.repeatType = RepeatType.never,
  }) : assert(isCompleted ^ (completedDate == null));

  bool get isOverdue =>
      completedDate == null && dueDate.isBefore(DateTimeUtils.today());

  bool get isRepeated => repeatType != RepeatType.never;

  Task copyWith({
    int? id,
    String? title,
    bool? isCompleted,
    DateTime? createdDate,
    DateTime? dueDate,
    required DateTime? completedDate,
    RepeatType? repeatType,
  }) {
    return Task(
      id: id ?? this.id,
      title: title ?? this.title,
      isCompleted: isCompleted ?? this.isCompleted,
      createdDate: createdDate ?? this.createdDate,
      dueDate: dueDate ?? this.dueDate,
      completedDate: completedDate,
      repeatType: repeatType ?? this.repeatType,
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
      [id, title, isCompleted, createdDate, dueDate, completedDate];

  @override
  bool get stringify => true;
}

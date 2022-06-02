import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'task.g.dart';

@JsonSerializable()
class Task extends Equatable {
  final int id;
  final String content;
  final bool isCompleted;
  final DateTime createdDate;
  final DateTime? dueDate;
  final DateTime? completedDate;

  const Task(
      {required this.id,
      required this.content,
      required this.isCompleted,
      required this.createdDate,
      this.dueDate,
      this.completedDate});

  Task copyWith({
    int? id,
    String? content,
    bool? isCompleted,
    DateTime? createdDate,
    DateTime? dueDate,
    DateTime? completedDate,
  }) {
    return Task(
      id: id ?? this.id,
      content: content ?? this.content,
      isCompleted: isCompleted ?? this.isCompleted,
      createdDate: createdDate ?? this.createdDate,
      dueDate: dueDate ?? this.dueDate,
      completedDate: completedDate ?? this.completedDate,
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
      [id, content, isCompleted, createdDate, dueDate, completedDate];

  @override
  bool get stringify => true;
}

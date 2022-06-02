// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      content: json['content'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdDate: DateTime.parse(json['createdDate'] as String),
      dueDate: json['dueDate'] == null
          ? null
          : DateTime.parse(json['dueDate'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'content': instance.content,
      'isCompleted': instance.isCompleted,
      'createdDate': instance.createdDate.toIso8601String(),
      'dueDate': instance.dueDate?.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
    };

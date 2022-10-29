// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool? ?? false,
      createdDate: DateTime.parse(json['createdDate'] as String),
      dateTime: DateTime.parse(json['dateTime'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'createdDate': instance.createdDate.toIso8601String(),
      'dateTime': instance.dateTime.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'task.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Task _$TaskFromJson(Map<String, dynamic> json) => Task(
      id: json['id'] as int,
      title: json['title'] as String,
      isCompleted: json['isCompleted'] as bool,
      createdDate: DateTime.parse(json['createdDate'] as String),
      dueDate: DateTime.parse(json['dueDate'] as String),
      completedDate: json['completedDate'] == null
          ? null
          : DateTime.parse(json['completedDate'] as String),
      repeatType: $enumDecode(_$RepeatTypeEnumMap, json['repeatType']),
    );

Map<String, dynamic> _$TaskToJson(Task instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'isCompleted': instance.isCompleted,
      'createdDate': instance.createdDate.toIso8601String(),
      'dueDate': instance.dueDate.toIso8601String(),
      'completedDate': instance.completedDate?.toIso8601String(),
      'repeatType': _$RepeatTypeEnumMap[instance.repeatType],
    };

const _$RepeatTypeEnumMap = {
  RepeatType.never: 'never',
  RepeatType.day: 'day',
  RepeatType.week: 'week',
  RepeatType.month: 'month',
  RepeatType.year: 'year',
};

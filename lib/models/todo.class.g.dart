// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'todo.class.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as int,
      userId: json['userId'] as int,
      title: json['title'] as String,
      userName: json['userName'] as String?,
      completed: json['completed'] as bool? ?? true,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'title': instance.title,
      'userName': instance.userName,
      'completed': instance.completed,
    };

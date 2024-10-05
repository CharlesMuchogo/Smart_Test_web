// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_users_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetUsersDto _$GetUsersDtoFromJson(Map<String, dynamic> json) => GetUsersDto(
      message: json['message'] as String,
      users: (json['users'] as List<dynamic>)
          .map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetUsersDtoToJson(GetUsersDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'users': instance.users,
    };

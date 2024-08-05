// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: (json['id'] as num).toInt(),
      firstName: json['firstName'] as String,
      lastName: json['lastName'] as String,
      phone: json['phone'] as String,
      email: json['email'] as String,
      profilePhoto: json['profilePhoto'] as String,
      age: json['age'] as String,
      educationLevel: json['educationLevel'] as String,
      testedBefore: json['testedBefore'] as bool,
      gender: json['gender'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'phone': instance.phone,
      'email': instance.email,
      'profilePhoto': instance.profilePhoto,
      'age': instance.age,
      'educationLevel': instance.educationLevel,
      'testedBefore': instance.testedBefore,
      'gender': instance.gender,
    };

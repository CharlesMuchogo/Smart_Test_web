// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResult _$TestResultFromJson(Map<String, dynamic> json) => TestResult(
      id: (json['id'] as num).toInt(),
      uuid: json['uuid'] as String,
      results: json['results'] as String,
      partnerResults: json['partnerResults'] as String,
      image: json['image'] as String,
      status: json['status'] as String,
      partnerImage: json['partnerImage'] as String,
      care_option: json['care_option'] as String,
      user: User.fromJson(json['user'] as Map<String, dynamic>),
      date: json['date'] as String,
    );

Map<String, dynamic> _$TestResultToJson(TestResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
      'uuid': instance.uuid,
      'partnerResults': instance.partnerResults,
      'image': instance.image,
      'partnerImage': instance.partnerImage,
      'care_option': instance.care_option,
      'status': instance.status,
      'date': instance.date,
      'user': instance.user.toJson(),
    };

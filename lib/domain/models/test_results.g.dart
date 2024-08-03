// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_results.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResult _$TestResultFromJson(Map<String, dynamic> json) => TestResult(
      id: (json['id'] as num).toInt(),
      results: json['results'] as String,
      partnerResults: json['partnerResults'] as String,
      image: json['image'] as String,
      partnerImage: json['partnerImage'] as String,
      careOption: json['careOption'] as String?,
      userId: (json['userId'] as num).toInt(),
      date: json['date'] as String,
    );

Map<String, dynamic> _$TestResultToJson(TestResult instance) =>
    <String, dynamic>{
      'id': instance.id,
      'results': instance.results,
      'partnerResults': instance.partnerResults,
      'image': instance.image,
      'partnerImage': instance.partnerImage,
      'careOption': instance.careOption,
      'userId': instance.userId,
      'date': instance.date,
    };

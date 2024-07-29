// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'test_results_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TestResultsResponseDTO _$TestResultsResponseDTOFromJson(
        Map<String, dynamic> json) =>
    TestResultsResponseDTO(
      message: json['message'] as String,
      results: (json['results'] as List<dynamic>)
          .map((e) => TestResult.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$TestResultsResponseDTOToJson(
        TestResultsResponseDTO instance) =>
    <String, dynamic>{
      'message': instance.message,
      'results': instance.results,
    };

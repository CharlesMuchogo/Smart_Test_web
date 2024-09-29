// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_test_tesults_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UpdateTestResultsDTO _$UpdateTestResultsDTOFromJson(
        Map<String, dynamic> json) =>
    UpdateTestResultsDTO(
      uuid: json['uuid'] as String,
      results: json['results'] as String,
      partnerResults: json['partnerResults'] as String,
      status: json['status'] as String,
    );

Map<String, dynamic> _$UpdateTestResultsDTOToJson(
        UpdateTestResultsDTO instance) =>
    <String, dynamic>{
      'uuid': instance.uuid,
      'results': instance.results,
      'partnerResults': instance.partnerResults,
      'status': instance.status,
    };

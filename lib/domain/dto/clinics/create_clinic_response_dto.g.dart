// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_clinic_response_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateClinicResponseDto _$CreateClinicResponseDtoFromJson(
        Map<String, dynamic> json) =>
    CreateClinicResponseDto(
      message: json['message'] as String,
      clinic: Clinic.fromJson(json['clinic'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$CreateClinicResponseDtoToJson(
        CreateClinicResponseDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'clinic': instance.clinic,
    };

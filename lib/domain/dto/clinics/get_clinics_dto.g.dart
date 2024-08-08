// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_clinics_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetClinicsDto _$GetClinicsDtoFromJson(Map<String, dynamic> json) =>
    GetClinicsDto(
      message: json['message'] as String,
      clinics: (json['clinics'] as List<dynamic>)
          .map((e) => Clinic.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$GetClinicsDtoToJson(GetClinicsDto instance) =>
    <String, dynamic>{
      'message': instance.message,
      'clinics': instance.clinics,
    };

// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_clinic_request_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateClinicRequestDto _$CreateClinicRequestDtoFromJson(
        Map<String, dynamic> json) =>
    CreateClinicRequestDto(
      name: json['name'] as String,
      address: json['address'] as String,
      contacts: json['contacts'] as String,
      description: json['description'] as String,
    );

Map<String, dynamic> _$CreateClinicRequestDtoToJson(
        CreateClinicRequestDto instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
      'contacts': instance.contacts,
      'description': instance.description,
    };

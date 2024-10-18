
import 'package:json_annotation/json_annotation.dart';

import '../../models/clinic.dart';

part 'create_clinic_response_dto.g.dart';

@JsonSerializable()
class CreateClinicResponseDto {
  final String message;
  final Clinic clinic;


  CreateClinicResponseDto({
    required this.message,
    required this.clinic,
  });

  factory CreateClinicResponseDto.fromJson(Map<String, dynamic> json) => _$CreateClinicResponseDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateClinicResponseDtoToJson(this);
}

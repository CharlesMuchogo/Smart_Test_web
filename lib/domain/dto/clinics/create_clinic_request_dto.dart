
import 'package:json_annotation/json_annotation.dart';

import '../../models/clinic.dart';

part 'create_clinic_request_dto.g.dart';

@JsonSerializable()
class CreateClinicRequestDto {
  final String name;
  final String address;
  final String contacts;
  final String description;

  CreateClinicRequestDto({
    required this.name,
    required this.address,
    required this.contacts,
    required this.description,
  });

  factory CreateClinicRequestDto.fromJson(Map<String, dynamic> json) => _$CreateClinicRequestDtoFromJson(json);
  Map<String, dynamic> toJson() => _$CreateClinicRequestDtoToJson(this);
}

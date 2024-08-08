import 'package:json_annotation/json_annotation.dart';
import 'package:smart_app/domain/models/clinic.dart';

part 'get_clinics_dto.g.dart';

@JsonSerializable()
class GetClinicsDto {
  final String message;
  final List<Clinic> clinics;


  GetClinicsDto({
    required this.message,
    required this.clinics,
  });

  factory GetClinicsDto.fromJson(Map<String, dynamic> json) => _$GetClinicsDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetClinicsDtoToJson(this);
}

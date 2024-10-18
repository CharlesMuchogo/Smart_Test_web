import 'package:json_annotation/json_annotation.dart';

part 'clinic.g.dart';

@JsonSerializable()
class Clinic {
  final int id;
  final String name;
  final String address;
  final String contacts;
  final String description;
  final bool active;

  Clinic({
    required this.id,
    required this.name,
    required this.address,
    required this.contacts,
    required this.description,
    required this.active,
  });


  factory Clinic.fromJson(Map<String, dynamic> json) => _$ClinicFromJson(json);

  Map<String, dynamic> toJson() => _$ClinicToJson(this);
}

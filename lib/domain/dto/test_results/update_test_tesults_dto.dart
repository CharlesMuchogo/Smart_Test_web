import 'package:json_annotation/json_annotation.dart';

part 'update_test_tesults_dto.g.dart';

@JsonSerializable()
class UpdateTestResultsDTO {

  final String uuid;
  final String results;
  final String partnerResults;
  final String status;

  UpdateTestResultsDTO(
      {required this.uuid,
      required this.results,
      required this.partnerResults,
      required this.status});


  factory UpdateTestResultsDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateTestResultsDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTestResultsDTOToJson(this);
}

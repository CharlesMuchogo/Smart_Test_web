import 'package:json_annotation/json_annotation.dart';

part 'update_test_results_response_dto.g.dart';

@JsonSerializable()
class UpdateTestResultsResponseDTO {
  final String message;

  UpdateTestResultsResponseDTO({
    required this.message,
  });

  factory UpdateTestResultsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$UpdateTestResultsResponseDTOFromJson(json);

  Map<String, dynamic> toJson() => _$UpdateTestResultsResponseDTOToJson(this);
}
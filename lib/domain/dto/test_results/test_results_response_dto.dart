import 'package:json_annotation/json_annotation.dart';
import 'package:smart_app/domain/models/test_results.dart';

part 'test_results_response_dto.g.dart';

@JsonSerializable()
class TestResultsResponseDTO {
  final String message;
  final List<TestResult> results;

  TestResultsResponseDTO({
    required this.message,
    required this.results,
  });

  factory TestResultsResponseDTO.fromJson(Map<String, dynamic> json) =>
      _$TestResultsResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$TestResultsResponseDTOToJson(this);
}

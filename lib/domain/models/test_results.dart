import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'test_results.g.dart';

@JsonSerializable()
class TestResult extends Equatable {
  final int id;
  final String results;
  final String partnerResults;
  final String image;
  final String partnerImage;
  final String? careOption;
  final int userId;
  final String date;

  const TestResult({
    required this.id,
    required this.results,
    required this.partnerResults,
    required this.image,
    required this.partnerImage,
    this.careOption,
    required this.userId,
    required this.date,
  });

  @override
  List<Object?> get props => [
        id,
        results,
        partnerResults,
        image,
        partnerImage,
        careOption,
        userId,
        date,
      ];

  factory TestResult.fromJson(Map<String, dynamic> json) =>
      _$TestResultFromJson(json);
  Map<String, dynamic> toJson() => _$TestResultToJson(this);
}

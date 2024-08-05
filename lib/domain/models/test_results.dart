import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_app/domain/models/user.dart';

part 'test_results.g.dart';

@JsonSerializable()
class TestResult extends Equatable {
  final int id;
  final String results;
  final String partnerResults;
  final String image;
  final String partnerImage;
  final String? careOption;
  final String date;
  final User user;

  const TestResult({
    required this.id,
    required this.results,
    required this.partnerResults,
    required this.image,
    required this.partnerImage,
    this.careOption,
    required this.user,
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
        date,
        user
      ];

  factory TestResult.fromJson(Map<String, dynamic> json) => _$TestResultFromJson(json);
  Map<String, dynamic> toJson() => _$TestResultToJson(this);
}

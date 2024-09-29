// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'results_bloc.dart';

abstract class ResultsEvent extends Equatable {
  const ResultsEvent();

  @override
  List<Object> get props => [];
}

class GetTestResults extends ResultsEvent {
  final BuildContext context;
  const GetTestResults({required this.context});
}

class UpdateTestResults extends ResultsEvent {
  final BuildContext context;
  final UpdateTestResultsDTO resultsDTO;
  const UpdateTestResults( {required this.context, required this.resultsDTO});
}

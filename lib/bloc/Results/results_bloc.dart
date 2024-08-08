import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/test_results/test_results_response_dto.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends HydratedBloc<ResultsEvent, ResultsState> {
  final RemoteRepository repository;
  ResultsBloc({required this.repository}) : super(const ResultsState()) {
    on<GetTestResults>(_onGetTestResults);
  }

  void _onGetTestResults(
      GetTestResults event, Emitter<ResultsState> emit) async {
    emit(state.copyWith(status: ResultsStatus.loading));
    try {
      TestResultsResponseDTO results =
          await repository.getTestResults(all: true);

      emit(state.copyWith(
          status: ResultsStatus.loaded,
          message: results.message,
          results: results.results.map((e) => e.toJson()).toList()));
    } catch (e) {
      emit(state.copyWith(
          status: ResultsStatus.error, message: "Could not submit request"));
    }
  }

  @override
  ResultsState fromJson(Map<String, dynamic> data) {
    return ResultsState.fromJson(json.encode(data));
  }

  @override
  Map<String, dynamic>? toJson(ResultsState state) {
    if (state.status == ResultsStatus.loaded ||
        state.status == ResultsStatus.success) {
      return state.toMap();
    }
    return null;
  }

  @override
  void onChange(Change<ResultsState> change) {
    super.onChange(change);
    debugPrint('$change');
  }
}

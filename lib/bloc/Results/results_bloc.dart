import 'dart:convert';
import 'dart:developer';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/test_results/test_results_response_dto.dart';
import 'package:smart_app/domain/dto/test_results/update_test_results_response_dto.dart';
import 'package:smart_app/domain/dto/test_results/update_test_tesults_dto.dart';

part 'results_event.dart';
part 'results_state.dart';

class ResultsBloc extends HydratedBloc<ResultsEvent, ResultsState> {
  final RemoteRepository repository;

  ResultsBloc({required this.repository}) : super(const ResultsState()) {
    on<GetTestResults>(_onGetTestResults);
    on<UpdateTestResults>(_onUpdateTestResults);
  }

  void _onGetTestResults(GetTestResults event, Emitter<ResultsState> emit) async {

    if(state.results.isEmpty){
      emit(state.copyWith(status: ResultsStatus.loading));
    }

    try {
      TestResultsResponseDTO results =
          await repository.getTestResults(all: true);

      emit(state.copyWith(
          status: ResultsStatus.loaded,
          message: results.message,
          results: results.results.map((e) => e.toJson()).toList()));
    } catch (e) {
      emit(state.copyWith(
          status: ResultsStatus.error, message: "Error getting results"));
    }
  }

  void _onUpdateTestResults(
      UpdateTestResults event, Emitter<ResultsState> emit) async {


    try {
      emit(state.copyWith(status: ResultsStatus.updating));

      UpdateTestResultsResponseDTO response =
          await repository.updateTestResults(resultsDTO: event.resultsDTO);

      emit(state.copyWith(status: ResultsStatus.success, message: response.message));

      TestResultsResponseDTO results =  await repository.getTestResults(all: true);

      emit(state.copyWith(
          status: ResultsStatus.loaded,
          message: results.message,
          results: results.results.map((e) => e.toJson()).toList()));
    } catch (e) {
      emit(state.copyWith(
          status: ResultsStatus.failed,
          message: "Error updating results. Try again"));
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

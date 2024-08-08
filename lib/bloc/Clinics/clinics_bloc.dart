import 'dart:convert';
import 'dart:developer';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/clinics/get_clinics_dto.dart';

part 'clinics_event.dart';
part 'clinics_state.dart';

class ClinicsBloc extends HydratedBloc<ClinicsEvent, ClinicsState> {
  final RemoteRepository repository;
  ClinicsBloc({required this.repository}) : super(const ClinicsState()) {
    on<GetClinics>(_onGetClinics);
  }

  void _onGetClinics(
      GetClinics event, Emitter<ClinicsState> emit) async {
    emit(state.copyWith(status: ResultsStatus.loading));
    try {
      GetClinicsDto results =
          await repository.getClinics();

      emit(state.copyWith(
          status: ResultsStatus.loaded,
          message: results.message,
          clinics: results.clinics.map((e) => e.toJson()).toList()));
    } catch (e) {
      emit(state.copyWith(
          status: ResultsStatus.error, message: e.toString()));
    }
  }

  @override
  ClinicsState fromJson(Map<String, dynamic> data) {
    return ClinicsState.fromJson(json.encode(data));
  }

  @override
  Map<String, dynamic>? toJson(ClinicsState state) {
    if (state.status == ResultsStatus.loaded ||
        state.status == ResultsStatus.success) {
      return state.toMap();
    }
    return null;
  }

  @override
  void onChange(Change<ClinicsState> change) {
    super.onChange(change);
    debugPrint('$change');
  }
}

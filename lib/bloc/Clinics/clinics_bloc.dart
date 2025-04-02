import 'dart:convert';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/clinics/create_clinic_request_dto.dart';
import 'package:smart_app/domain/dto/clinics/create_clinic_response_dto.dart';
import 'package:smart_app/domain/dto/clinics/get_clinics_dto.dart';

part 'clinics_event.dart';

part 'clinics_state.dart';

class ClinicsBloc extends HydratedBloc<ClinicsEvent, ClinicsState> {
  final RemoteRepository repository;

  ClinicsBloc({required this.repository}) : super(const ClinicsState()) {
    on<GetClinics>(_onGetClinics);
    on<CreateClinic>(_onCreateClinic);
  }

  void _onGetClinics(GetClinics event, Emitter<ClinicsState> emit) async {
    if (state.status == ClinicsStatus.initial) {
      emit(state.copyWith(status: ClinicsStatus.loading));
    }

    try {
      GetClinicsDto results = await repository.getClinics();

      emit(state.copyWith(
          status: ClinicsStatus.loaded,
          message: results.message,
          clinics: results.clinics.map((e) => e.toJson()).toList()));
    } catch (e) {
      emit(state.copyWith(status: ClinicsStatus.error, message: e.toString()));
    }
  }

  void _onCreateClinic(CreateClinic event, Emitter<ClinicsState> emit) async {
    emit(state.copyWith(status: ClinicsStatus.loading));
    try {
      CreateClinicResponseDto results =
          await repository.createClinic(request: event.request);

      emit(
        state.copyWith(status: ClinicsStatus.success, message: results.message),
      );

      GetClinicsDto clinicsResponse = await repository.getClinics();

      emit(state.copyWith(
          status: ClinicsStatus.loaded,
          message: results.message,
          clinics: clinicsResponse.clinics.map((e) => e.toJson()).toList()));

    } catch (e) {
      emit(state.copyWith(status: ClinicsStatus.failed, message: e.toString()));
    }
  }

  @override
  ClinicsState fromJson(Map<String, dynamic> data) {
    return ClinicsState.fromJson(json.encode(data));
  }

  @override
  Map<String, dynamic>? toJson(ClinicsState state) {
    if (state.status == ClinicsStatus.loaded ||
        state.status == ClinicsStatus.success) {
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

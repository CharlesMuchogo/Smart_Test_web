import 'package:smart_app/bloc/Users/users_bloc.dart';
import 'package:smart_app/domain/dto/clinics/create_clinic_request_dto.dart';
import 'package:smart_app/domain/dto/clinics/create_clinic_response_dto.dart';
import 'package:smart_app/domain/dto/clinics/get_clinics_dto.dart';
import 'package:smart_app/domain/dto/test_results/test_results_response_dto.dart';
import 'package:smart_app/domain/dto/test_results/update_test_results_response_dto.dart';
import 'package:smart_app/domain/dto/users/get_users_dto.dart';

import '../domain/dto/login_response_dto.dart';
import '../domain/dto/test_results/update_test_tesults_dto.dart';

abstract class RemoteRepository {
  Future<LoginResponseDTO> login(String email, String password);

  Future<TestResultsResponseDTO> getTestResults({required bool all});

  Future<UpdateTestResultsResponseDTO> updateTestResults(
      {required UpdateTestResultsDTO resultsDTO});

  Future<GetClinicsDto> getClinics();

  Future<CreateClinicResponseDto> createClinic(
      {required CreateClinicRequestDto request});

  Future<GetUsersDto> getUsers();
}

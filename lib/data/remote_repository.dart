import 'package:smart_app/domain/dto/clinics/get_clinics_dto.dart';
import 'package:smart_app/domain/dto/test_results/test_results_response_dto.dart';

import '../domain/dto/login_response_dto.dart';

abstract class RemoteRepository {
  Future<LoginResponseDTO> login(String email, String password);
  Future<TestResultsResponseDTO> getTestResults({required bool all});
  Future<GetClinicsDto> getClinics();
}

import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/Utils/utils.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/clinics/get_clinics_dto.dart';
import 'package:smart_app/domain/dto/login_response_dto.dart';
import 'package:smart_app/domain/dto/test_results/test_results_response_dto.dart';
import 'package:smart_app/domain/dto/test_results/update_test_results_response_dto.dart';

import '../domain/dto/test_results/update_test_tesults_dto.dart';

class RemoteRepositoryImpl extends RemoteRepository {
  final dio = Dio();

  RemoteRepositoryImpl() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<LoginResponseDTO> login(String email, String password) async {
    try {
      var data = {
        "email": email,
        "password": password,
      };
      Response response = await dio.post(
        "/api/login",
        data: data,
      );
      return LoginResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      String? message = e.response?.data["message"].toString();
      log(message.toString());
      throw Exception(message);
    } catch (e) {
      log(e.toString());
      throw Exception("Something went wrong. Try again");
    }
  }

  @override
  Future<TestResultsResponseDTO> getTestResults({required bool all}) async {
    log(HydratedBloc.storage.read("token") ?? "");

    try {
      Response response = await dio.get("/api/mobile/results?all=$all",
          options: Options(headers: {
            'Authorization': HydratedBloc.storage.read("token") ?? ""
          }));
      return TestResultsResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      String? message = e.response?.data["message"].toString();
      log(message.toString());
      throw Exception(message);
    } catch (e) {
      log(e.toString());
      throw Exception("Something went wrong. Try again");
    }
  }

  @override
  Future<GetClinicsDto> getClinics() async {
    try {
      Response response = await dio.get("/api/mobile/clinics",
          options: Options(headers: {
            'Authorization': HydratedBloc.storage.read("token") ?? ""
          }));
      return GetClinicsDto.fromJson(response.data);
    } on DioException catch (e) {
      String? message = e.response?.data["message"].toString();
      log(message.toString());
      throw Exception(message);
    } catch (e) {
      log(e.toString());
      throw Exception("Something went wrong. Try again");
    }
  }

  @override
  Future<UpdateTestResultsResponseDTO> updateTestResults({required UpdateTestResultsDTO resultsDTO}) async {
    try {
      Response response = await dio.put("/api/mobile/results",
          data: resultsDTO.toJson(),
          options: Options(
              headers: {
            'Authorization': HydratedBloc.storage.read("token") ?? ""
          }));

      return UpdateTestResultsResponseDTO.fromJson(response.data);
    } on DioException catch (e) {
      log("error$e");
      String? message = e.response?.data["message"].toString();
      log(message.toString());
      throw Exception(message);
    } catch (e) {
      log("exception$e");
      throw Exception("Something went wrong. Try again!");
    }
  }
}

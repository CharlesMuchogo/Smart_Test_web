
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/login_response_dto.dart';

class RemoteRepositoryImpl extends RemoteRepository{
  final dio = Dio();
  final String baseUrl = "http://192.168.0.104:9000";

  RemoteRepositoryImpl() {
    dio.options.baseUrl = baseUrl;
    dio.options.headers = {
      'Content-Type': 'application/json',
    };
  }

  @override
  Future<LoginResponseDTO> login(String email, String password) async{
    try{
      var data = {
        "email": email,
        "password": password,
      };
      Response response = await dio.post(
        "/api/login",
        data: data,
      );
      return LoginResponseDTO.fromJson(response.data);
    } on DioException catch (e){
      String? message = e.response?.data["message"].toString();
      log(message.toString());
      throw Exception(message);
    } catch(e){
      log(e.toString());
      throw Exception("Something went wrong $e. Try again");
    }
  }

}
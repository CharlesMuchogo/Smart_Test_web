
import '../domain/dto/login_response_dto.dart';

abstract class RemoteRepository{
  Future<LoginResponseDTO> login(String email, String password);
}
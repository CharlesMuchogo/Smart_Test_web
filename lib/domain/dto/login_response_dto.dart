import 'package:json_annotation/json_annotation.dart';

import '../models/user.dart';

part 'login_response_dto.g.dart';

@JsonSerializable()
class LoginResponseDTO {
  final String message;
  final String token;
  final User user;

  LoginResponseDTO({
    required this.message,
    required this.token,
    required this.user,
  });

  factory LoginResponseDTO.fromJson(Map<String, dynamic> json) => _$LoginResponseDTOFromJson(json);
  Map<String, dynamic> toJson() => _$LoginResponseDTOToJson(this);
}

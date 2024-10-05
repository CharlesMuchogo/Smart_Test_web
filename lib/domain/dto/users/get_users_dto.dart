
import 'package:json_annotation/json_annotation.dart';
import 'package:smart_app/domain/models/clinic.dart';
import 'package:smart_app/domain/models/user.dart';

part 'get_users_dto.g.dart';

@JsonSerializable()
class GetUsersDto {
  final String message;
  final List<User> users;


  GetUsersDto({
    required this.message,
    required this.users,
  });

  factory GetUsersDto.fromJson(Map<String, dynamic> json) => _$GetUsersDtoFromJson(json);
  Map<String, dynamic> toJson() => _$GetUsersDtoToJson(this);
}

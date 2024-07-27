// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}


class Login extends LoginEvent {
  final String email;

  final String password;

  const Login({
    required this.email,
    required this.password,
  });
}

class CheckAuthentication extends LoginEvent {
  final BuildContext context;
  const CheckAuthentication({
    required this.context,
  });
}


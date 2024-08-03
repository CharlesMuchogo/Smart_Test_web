import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/bloc/Login/login_bloc.dart';
import 'package:smart_app/presentation/authentication/LoginPage.dart';
import 'package:smart_app/presentation/homepage/Homepage.dart';

class AuthenticationWrapper extends StatelessWidget {
  const AuthenticationWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return HydratedBloc.storage.read("token") == null
        ? const LoginPage()
        : const Homepage();
  }
}

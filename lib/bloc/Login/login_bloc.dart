import 'dart:convert';
import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/login_response_dto.dart';
import 'package:smart_app/domain/models/user.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends HydratedBloc<LoginEvent, LoginState> {
  final RemoteRepository repository;
  LoginBloc({required this.repository}) : super(const LoginState()) {
    on<Login>(_onLogin);
    on<CheckAuthentication>(onCheckLogin);
  }

  void onCheckLogin(CheckAuthentication event, Emitter<LoginState> emit) async {
    if (state.status == LoginStatus.initial) {
      emit(state.copyWith(status: LoginStatus.loading));
    }
  }

  void _onLogin(Login event, Emitter<LoginState> emit) async {
    emit(state.copyWith(status: LoginStatus.loading));
    try {
      LoginResponseDTO response =
          await repository.login(event.email, event.password);
      User user = response.user;
      String token = response.token;

      await HydratedBloc.storage.write("token", token);
      await HydratedBloc.storage.write("firstname", user.firstName);
      await HydratedBloc.storage.write("email", user.email);
      await HydratedBloc.storage.write("id", user.id);
      await HydratedBloc.storage.write("lastName", user.lastName);
      await HydratedBloc.storage.write("phoneNumber", user.phone);
      await HydratedBloc.storage.write("status", true);
      await HydratedBloc.storage.write("profile_photo", user.profilePhoto);

      emit(state.copyWith(
          status: LoginStatus.success,
          message: "Logged in successfully",
          loggedIn: true));
    } catch (e) {
      emit(state.copyWith(status: LoginStatus.error, message: e.toString()));
    }
  }

  @override
  LoginState fromJson(Map<String, dynamic> data) {
    return LoginState.fromJson(json.encode(data));
  }

  @override
  Map<String, dynamic>? toJson(LoginState state) {
    if (state.status == LoginStatus.loaded ||
        state.status == LoginStatus.success) {
      return state.toMap();
    }
    return null;
  }

  @override
  void onChange(Change<LoginState> change) {
    super.onChange(change);
    debugPrint('$change');
  }
}

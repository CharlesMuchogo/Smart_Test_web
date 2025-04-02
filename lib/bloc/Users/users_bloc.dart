import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:smart_app/data/remote_repository.dart';
import 'package:smart_app/domain/dto/users/get_users_dto.dart';

part 'users_event.dart';
part 'users_state.dart';

class UsersBloc extends HydratedBloc<UsersEvent, UsersState> {
  final RemoteRepository repository;

  UsersBloc({required this.repository}) : super(const UsersState()) {
    on<GetUsers>(_onGetUsers);
  }

  void _onGetUsers(GetUsers event, Emitter<UsersState> emit) async {

    if(state.status == UsersBlocStatus.initial){
      emit(state.copyWith(status: UsersBlocStatus.loading));
    }

    try {

      GetUsersDto results = await repository.getUsers();

      emit(state.copyWith(
          status: UsersBlocStatus.loaded,
          message: results.message,
          users: results.users.map((e) => e.toJson()).toList()));
    } catch (e) {
      emit(state.copyWith(status: UsersBlocStatus.error, message: e.toString()));
    }
  }

  @override
  UsersState fromJson(Map<String, dynamic> data) {
    return UsersState.fromJson(json.encode(data));
  }

  @override
  Map<String, dynamic>? toJson(UsersState state) {
    if (state.status == UsersBlocStatus.loaded ||
        state.status == UsersBlocStatus.success) {
      return state.toMap();
    }
    return null;
  }

  @override
  void onChange(Change<UsersState> change) {
    super.onChange(change);
    debugPrint('$change');
  }
}

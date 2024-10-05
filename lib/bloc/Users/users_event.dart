// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'users_bloc.dart';

abstract class UsersEvent extends Equatable {
  const UsersEvent();

  @override
  List<Object> get props => [];
}

class GetUsers extends UsersEvent {
  final BuildContext context;
  const GetUsers({required this.context});
}

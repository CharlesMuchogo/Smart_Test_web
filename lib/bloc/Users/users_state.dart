part of 'users_bloc.dart';

class UsersState extends Equatable {
  final List users;
  final ResultsStatus status;
  final String message;

  const UsersState(
      {this.users = const [],
      this.status = ResultsStatus.initial,
      this.message = ""}
      );

  UsersState copyWith({
    List? users,
    String? message,
    ResultsStatus? status,
  }) {
    return UsersState(
        users: users ?? this.users,
        status: status ?? this.status,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [users, status];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'users': users,
      'status': status.index,
    };
  }

  factory UsersState.fromMap(Map<String, dynamic> map) {
    int index = map['status'];

    return UsersState(
      users: List.from((map['clinics'] as List)),
      status: ResultsStatus.values[index],
    );
  }

  String toJson() => json.encode(toMap());

  factory UsersState.fromJson(String source) =>
      UsersState.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ResultsStatus {
  initial,
  loading,
  loaded,
  error,
  failed,
  success,
}

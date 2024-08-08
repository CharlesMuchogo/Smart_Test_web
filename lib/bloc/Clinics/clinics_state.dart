part of 'clinics_bloc.dart';

class ClinicsState extends Equatable {
  final List clinics;
  final ResultsStatus status;
  final String message;
  final bool loggedIn;

  const ClinicsState(
      {this.clinics = const [],
      this.status = ResultsStatus.initial,
      this.loggedIn = false,
      this.message = ""});

  ClinicsState copyWith({
    List? clinics,
    String? message,
    ResultsStatus? status,
    bool? loggedIn,
  }) {
    return ClinicsState(
        clinics: clinics ?? this.clinics,
        status: status ?? this.status,
        loggedIn: loggedIn ?? this.loggedIn,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [clinics, status];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'clinics': clinics,
      'status': status.index,
    };
  }

  factory ClinicsState.fromMap(Map<String, dynamic> map) {
    int index = map['status'];

    return ClinicsState(
      clinics: List.from((map['clinics'] as List)),
      status: ResultsStatus.values[index],
    );
  }

  String toJson() => json.encode(toMap());

  factory ClinicsState.fromJson(String source) =>
      ClinicsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ResultsStatus {
  initial,
  loading,
  loaded,
  error,
  failed,
  success,
}

part of 'results_bloc.dart';

class ResultsState extends Equatable {
  final List results;
  final ResultsStatus status;
  final String message;
  final bool loggedIn;

  const ResultsState(
      {this.results = const [],
      this.status = ResultsStatus.initial,
      this.loggedIn = false,
      this.message = ""});

  ResultsState copyWith({
    List? results,
    String? message,
    ResultsStatus? status,
    bool? loggedIn,
  }) {
    return ResultsState(
        results: results ?? this.results,
        status: status ?? this.status,
        loggedIn: loggedIn ?? this.loggedIn,
        message: message ?? this.message);
  }

  @override
  List<Object> get props => [results, status];

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'results': results,
      'status': status.index,
    };
  }

  factory ResultsState.fromMap(Map<String, dynamic> map) {
    int index = map['status'];

    return ResultsState(
      results: List.from((map['results'] as List)),
      status: ResultsStatus.values[index],
    );
  }

  String toJson() => json.encode(toMap());

  factory ResultsState.fromJson(String source) =>
      ResultsState.fromMap(json.decode(source) as Map<String, dynamic>);
}

enum ResultsStatus {
  initial,
  loading,
  loaded,
  error,
  failed,
  success,
}

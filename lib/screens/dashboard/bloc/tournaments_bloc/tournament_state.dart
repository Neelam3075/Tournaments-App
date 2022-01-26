part of 'tournament_bloc.dart';

class TournamentState extends Equatable {
  final GetTournamentsResponse? getTournamentsResponse;
  final bool? isLoading;

  final String? message;

  final bool? isSuccess;
  final List<Tournaments>? tournamentList;

  final bool? retry;

  TournamentState copyWith(
      {GetTournamentsResponse? getTournamentsResponse,
      bool? isLoading,
      String? message,
      bool? isSuccess,
      List<Tournaments>? tournamentList,
      bool? retry}) {
    return TournamentState(
        getTournamentsResponse:
            getTournamentsResponse ?? this.getTournamentsResponse,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isSuccess: isSuccess ?? this.isSuccess,
        tournamentList: tournamentList ?? this.tournamentList,

        retry: retry ?? this.retry);
  }

  const TournamentState(
      {this.getTournamentsResponse,
      this.isLoading,
      this.message,
      this.isSuccess,
      this.tournamentList,
      this.retry});

  @override
  List<Object?> get props => [
        getTournamentsResponse,
        message,
        isLoading,
        isSuccess,
        tournamentList,
        retry
      ];
}

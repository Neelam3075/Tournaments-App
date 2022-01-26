part of 'tournament_bloc.dart';

abstract class TournamentEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetTournamentsEvent extends TournamentEvent {
  final GetTournamentsRequest? getTournamentsRequest;
  final bool? isScrollMore;

  GetTournamentsEvent({this.getTournamentsRequest, this.isScrollMore});

  @override
  List<Object?> get props => [getTournamentsRequest, isScrollMore];
}

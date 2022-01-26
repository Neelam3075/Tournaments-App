import 'package:bluestack_demo/l10n/l10n.dart';
import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/screens/dashboard/dashboard_repository.dart';
import 'package:bluestack_demo/screens/dashboard/models/get_tournaments_request.dart';
import 'package:bluestack_demo/screens/dashboard/models/get_tournaments_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'tournament_event.dart';

part 'tournament_state.dart';

class TournamentBLoC extends Bloc<TournamentEvent, TournamentState> {
  TournamentBLoC({required DashboardRepository dashboardRepository})
      : _dashboardRepository = dashboardRepository,
        super(const TournamentState(retry: false)) {
    on<GetTournamentsEvent>(_getTournamentsList);
  }

  final DashboardRepository _dashboardRepository;

  _getTournamentsList(
      GetTournamentsEvent event, Emitter<TournamentState> emitter) async {
    if (!(state.getTournamentsResponse?.tournamentsDetail?.isLastBatch ??
        false)) {
      emitter(state.copyWith(retry: false));
      GetTournamentsRequest? request = event.getTournamentsRequest;
      request?.cursor =
          state.getTournamentsResponse?.tournamentsDetail?.cursor ?? "";

      GetTournamentsResponse getTournamentsResponse =
          await _dashboardRepository.getTournaments(
              request: event.getTournamentsRequest,
              isLoading: (isLoading) {
                emitter(state.copyWith(
                    isLoading: isLoading,
                    message: (event.isScrollMore ?? true)
                        ? Translate().l10n.loadingMore
                        : null,
                    retry: false));
              });
      if (getTournamentsResponse.success != null &&
          getTournamentsResponse.success!) {
        List<Tournaments> oldList = state.tournamentList ?? [];
        oldList.addAll(
            getTournamentsResponse.tournamentsDetail?.tournamentList ?? []);
        emitter(state.copyWith(
            isLoading: false,
            tournamentList: oldList,
            isSuccess: true,
            getTournamentsResponse: getTournamentsResponse,
            retry: false));
      } else {
        emitter(state.copyWith(
            isLoading: false,
            isSuccess: false,
            message: getTournamentsResponse.tournamentsDetail?.error ??
                Translate().l10n.somethingWentWrong,
            retry: false));
      }
    } else {
      emitter(state.copyWith(
          isLoading: false,
          isSuccess: true,
          message: Translate().l10n.noMoreData,
          retry: true));
    }
  }
}

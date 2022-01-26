
import 'package:bluestack_demo/screens/dashboard/dashboard_repository.dart';
import 'package:bluestack_demo/screens/login/models/login_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBLoC extends Bloc<ProfileEvent, ProfileState> {
  ProfileBLoC({required DashboardRepository repo})
      : _dashboardRepository = repo,
        super(const ProfileState()) {
    on<GetUserProfileEvent>(_getProfile);
  }

  final DashboardRepository _dashboardRepository;

  _getProfile(GetUserProfileEvent event, Emitter<ProfileState> emitter) async {
    LoginResponse response =
        await _dashboardRepository.getProfile(isLoading: (isLoading) {
      emitter(state.copyWith(isLoading: isLoading));
    });

    if (response.status??false) {
      emitter(
          state.copyWith(isLoading: false, isSuccess: true, profile: response));
    } else {
      emitter(state.copyWith(
          isLoading: false,
          profile: null,
          isSuccess: false,
          message: response.message));
    }
  }
}

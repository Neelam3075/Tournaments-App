part of 'profile_bloc.dart';

abstract class ProfileEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetUserProfileEvent extends ProfileEvent {
  GetUserProfileEvent();

  @override
  List<Object?> get props => [];
}

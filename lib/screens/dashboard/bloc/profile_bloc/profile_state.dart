part of 'profile_bloc.dart';


class ProfileState extends Equatable {
  final LoginResponse? profile;
  final bool? isLoading;
  final String? message;
  final bool? isSuccess;

  ProfileState copyWith(
      {LoginResponse? profile,
        bool? isLoading,
        String? message,
        bool? isSuccess,}) {
    return ProfileState(
        profile: profile ?? this.profile,
        isLoading: isLoading ?? this.isLoading,
        message: message ?? this.message,
        isSuccess: isSuccess ?? this.isSuccess,);
  }

  const ProfileState(
      {this.profile,
        this.isLoading,
        this.message,
        this.isSuccess});

  @override
  List<Object?> get props => [
    profile,
    message,
    isLoading,
    isSuccess,
  ];
}

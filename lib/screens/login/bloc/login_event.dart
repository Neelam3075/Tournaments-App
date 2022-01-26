part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object?> get props => [];
}

class ResetLogin extends LoginEvent {
  const ResetLogin();

  @override
  List<Object?> get props => [];
}

class LoginSubmitEvent extends LoginEvent {
  final LoginRequest? loginRequest;

  const LoginSubmitEvent({this.loginRequest});

  @override
  List<Object?> get props => [loginRequest?.userName, loginRequest?.password];
}

class UserNameChangedEvent extends LoginEvent {
  final String? userName;

  const UserNameChangedEvent({this.userName});

  @override
  List<Object?> get props => [userName];
}

class PasswordChangedEvent extends LoginEvent {
  final String? password;

  const PasswordChangedEvent({this.password});

  @override
  List<Object?> get props => [password];
}
part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object?> get props => [];
}

class AuthStatusState extends AuthState {
  const AuthStatusState({this.authStatus});

  final AuthStatus? authStatus;

  @override
  List<Object?> get props => [authStatus];
}

class LanguageChangeState extends AuthState {
  final Locale locale;

  const LanguageChangeState({required this.locale});

  @override

  List<Object?> get props => [locale];
}

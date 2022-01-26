part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class AuthStatusChangedEvent extends AuthEvent {
  final AuthStatus authStatus;

  const AuthStatusChangedEvent({required this.authStatus});

  @override
  List<Object?> get props => [authStatus];
}

class SelectLanguageEvent extends AuthEvent {
  final Locale locale;

  const SelectLanguageEvent({required
    this.locale,
  });

  @override
  List<Object?> get props => [locale];
}

import 'dart:ui';

import 'package:bluestack_demo/resources%20/strings.dart';
import 'package:bluestack_demo/screens/login/login_repository.dart';
import 'package:bluestack_demo/utils/pref_keys.dart';
import 'package:bluestack_demo/utils/prefs.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'auth_event.dart';

part 'auth_state.dart';

class AuthBLoC extends Bloc<AuthEvent, AuthState> {
  AuthBLoC({required LoginRepo repo, required String languageCode})
      : super(const AuthStatusState(authStatus: AuthStatus.unknown)) {
    _getLanguageCoe();
    on<AuthStatusChangedEvent>(_changeLoginStatus);
    on<SelectLanguageEvent>(_changeLanguage);
    repo.getLoginStatus.listen((event) {
      add(AuthStatusChangedEvent(authStatus: event));
    });
  }

  _changeLanguage(SelectLanguageEvent event, Emitter<AuthState> emitter) async {
    Prefs.setString(
        PrefKeys.language, event.locale.languageCode );
    emitter(LanguageChangeState(locale: event.locale));
  }

  _changeLoginStatus(AuthStatusChangedEvent event, Emitter<AuthState> emitter) {
    switch (event.authStatus) {
      case AuthStatus.authenticated:
        {
          return emitter(
              const AuthStatusState(authStatus: AuthStatus.authenticated));
        }
      case AuthStatus.unknown:
        return emitter(
            const AuthStatusState(authStatus: AuthStatus.unauthenticated));

      case AuthStatus.unauthenticated:
        return emitter(
            const AuthStatusState(authStatus: AuthStatus.unauthenticated));
    }
  }

  void _getLanguageCoe() async {
    String language = await Prefs.getString(PrefKeys.language) ?? Strings.en;
    add(SelectLanguageEvent(locale: Locale(language, '')));
  }
}

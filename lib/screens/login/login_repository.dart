import 'dart:async';

import 'package:bluestack_demo/l10n/l10n.dart';
import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/screens/login/models/login_request.dart';
import 'package:bluestack_demo/screens/login/models/login_response.dart';
import 'package:bluestack_demo/utils/pref_keys.dart';
import 'package:bluestack_demo/utils/prefs.dart';

enum AuthStatus { unknown, authenticated, unauthenticated }

class LoginRepo {
  final _statusController = StreamController<AuthStatus>();

  Stream<AuthStatus> get getLoginStatus async* {
    String? getUserInfo = await Prefs.getString(PrefKeys.userInfo);
    if (getUserInfo != null && getUserInfo.isNotEmpty) {
      yield AuthStatus.authenticated;
      yield* _statusController.stream;
    } else {
      yield AuthStatus.unauthenticated;
      yield* _statusController.stream;
    }
  }

  Map<String, LoginResponse> usersCred = {
    '9898989898': LoginResponse(password: 'password123', id: '61ecd883f701f46000063424'),
    '9876543210': LoginResponse(password: 'password123', id: '61ecdbfaf701f4600006343b')
  };

  Future<LoginResponse> login({LoginRequest? loginRequest}) async {
    if (loginRequest != null &&
        loginRequest.userName != null &&
        loginRequest.password != null) {
      if (usersCred.containsKey(loginRequest.userName)) {
        LoginResponse? loginResponse = usersCred[loginRequest.userName];
        if (loginResponse!=null && loginResponse.password == loginRequest.password) {
          Prefs.setString(PrefKeys.userInfo, loginResponse.id ?? "");
          loginResponse.status = true;
          return loginResponse;
        } else {
          return LoginResponse(
              status: false, message: Translate().l10n.invalidCredentials);
        }
      } else {
        return LoginResponse(
            status: false, message: Translate().l10n.userDoesNotExist);
      }
    } else {
      return LoginResponse(
          status: false, message: Translate().l10n.invalidCredentials);
    }
  }
}

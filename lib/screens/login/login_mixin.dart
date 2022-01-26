import 'package:bluestack_demo/l10n/l10n.dart';
import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/screens/login/models/login_request.dart';

mixin LoginMixin {
  String? validateUserName(String? userName) {
    if (userName == null || userName.isEmpty) {
      return Translate().l10n.userNameShouldNotBeEmpty;
    } else if (userName.length < 3) {
      return Translate().l10n.userNameLengthShouldNotBeLessThen3;
    } else if (userName.length > 11) {
      return Translate().l10n.userNameLengthShouldNotBeMoreThen11;
    } else {
      return null;
    }
  }

  String? validatePassword(String? password) {
    if (password == null || password.isEmpty) {
      return Translate().l10n.passwordShouldNotBeEmpty;
    } else if (password.length < 3) {
      return Translate().l10n.passwordShouldNotBeLessThen3;
    } else if (password.length > 11) {
      return Translate().l10n.passwordShouldNotBeMoreThen11;
    } else {
      return null;
    }
  }

  bool isValidRequest(LoginRequest? loginRequest) {
    if (loginRequest != null &&
        (loginRequest.userName != null &&
            loginRequest.userName!.isNotEmpty &&
            loginRequest.userName!.length > 2 &&
            loginRequest.userName!.length < 12) &&
        (loginRequest.password != null &&
            loginRequest.password!.isNotEmpty &&
            loginRequest.password!.length > 2 &&
            loginRequest.password!.length < 12)) {
      return true;
    } else {
      return false;
    }
  }
}

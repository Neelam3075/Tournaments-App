import 'package:bluestack_demo/screens/login/login_mixin.dart';
import 'package:bluestack_demo/screens/login/login_repository.dart';
import 'package:bluestack_demo/screens/login/models/login_request.dart';
import 'package:bluestack_demo/screens/login/models/login_response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> with LoginMixin {
  LoginBloc({required LoginRepo loginRepo})
      : _loginRepo = loginRepo,
        super(const LoginState()) {
    on<LoginSubmitEvent>(_login);
    on<UserNameChangedEvent>(_userNameChange);
    on<PasswordChangedEvent>(_passwordChange);
    on<ResetLogin>(_resetLogin);
  }

  _resetLogin(ResetLogin event, Emitter<LoginState> emitter) {
    emitter(state.copyWith(loginResponse: null, msg: null));
  }

  final LoginRepo _loginRepo;

  _userNameChange(UserNameChangedEvent event, Emitter<LoginState> emitter) {
    var userName = event.userName;
    // LoginRequest loginRequest = state.loginRequest ?? LoginRequest();
    LoginRequest newReq = LoginRequest(
        userName: userName, password: state.loginRequest?.password);
    emitter(state.copyWith(loginRequest: newReq));
  }

  _passwordChange(PasswordChangedEvent event, Emitter<LoginState> emitter) {
    var password = event.password;
    //   LoginRequest loginRequest = state.loginRequest ?? LoginRequest();
    LoginRequest newReq = LoginRequest(
        userName: state.loginRequest?.userName, password: password);

    emitter(state.copyWith(loginRequest: newReq));
  }

  _login(LoginSubmitEvent event, Emitter<LoginState> emitter) async {
    emitter(state.copyWith(isLoading: true));
    LoginResponse? loginResponse =
        await _loginRepo.login(loginRequest: event.loginRequest);
    emitter(state.copyWith(
        loginResponse: loginResponse,
        isLoading: false,
        isSuccess: loginResponse.status));
  }
}

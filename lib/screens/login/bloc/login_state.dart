part of 'login_bloc.dart';

class LoginState extends Equatable {
  final LoginRequest? loginRequest;
  final LoginResponse? loginResponse;
  final String? msg;

  final bool? isLoading;

  final bool? isSuccess;

  const LoginState(
      {this.loginRequest,
      this.loginResponse,
      this.isLoading,
      this.isSuccess,
      this.msg});

  @override
  List<Object?> get props =>
      [loginRequest, loginResponse, isLoading, isSuccess, msg];

  LoginState copyWith(
      {LoginRequest? loginRequest,
      LoginResponse? loginResponse,
      bool? isLoading,
      bool? isSuccess,
      String? msg}) {
    return LoginState(
        isSuccess: isSuccess ?? this.isSuccess,
        isLoading: isLoading ?? this.isLoading,
        loginRequest: loginRequest ?? this.loginRequest,
        loginResponse: loginResponse ?? this.loginResponse,
        msg: msg ?? this.msg);
  }
}
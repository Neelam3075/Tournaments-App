import 'package:bluestack_demo/custom_widget/text_widget.dart';
import 'package:bluestack_demo/l10n/l10n.dart';
import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/resources%20/app_colors.dart';
import 'package:bluestack_demo/resources%20/app_images.dart';
import 'package:bluestack_demo/resources%20/strings.dart';
import 'package:bluestack_demo/screens/login/bloc/login_bloc.dart';
import 'package:bluestack_demo/screens/login/login_repository.dart';
import 'package:bluestack_demo/screens/splash/bloc/auth_bloc.dart';
import 'package:bluestack_demo/utils/app_utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Center(child: LoginForm()),
        ));
  }
}

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
              margin: const EdgeInsets.symmetric(vertical: 40),
              child: Image.asset(
                AppImages.gameTvLogo,
              )),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return context.read<LoginBloc>().validateUserName(value);
            },
            textInputAction: TextInputAction.next,
            onChanged: (value) {
              context
                  .read<LoginBloc>()
                  .add(UserNameChangedEvent(userName: value.trim()));
            },
            decoration:  InputDecoration(
                label: TextWidget(
                  text: Translate().l10n.userName,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900),
                ),
                hintText: context.l10n.enterYourName,
                suffixIcon: const Icon(
                  Icons.account_circle_rounded,
                )),
          ),
          TextFormField(
            autovalidateMode: AutovalidateMode.onUserInteraction,
            validator: (value) {
              return context.read<LoginBloc>().validatePassword(value);
            },
            textInputAction: TextInputAction.done,
            obscureText: true,
            onChanged: (value) {
              context
                  .read<LoginBloc>()
                  .add(PasswordChangedEvent(password: value.trim()));
            },
            decoration: InputDecoration(
                label: TextWidget(
                  text: context.l10n.password,
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.w900),
                ),
                focusColor: AppColors.black,
                hintText: context.l10n.enterPassword,
                suffixIcon: const Icon(Icons.password_sharp)),
          ),
          BlocConsumer<LoginBloc, LoginState>(
            listener: (context, state) {
              if (state.loginResponse != null) {
                if (state.loginResponse?.status ?? false) {
                  context.read<AuthBLoC>().add(const AuthStatusChangedEvent(
                      authStatus: AuthStatus.authenticated));
                } else {
                  AppUtils.showValidationDialog(
                      context, state.loginResponse?.message ?? "" ,buttonText: context.l10n.ok);

                  context.read<LoginBloc>().add(const ResetLogin());
                }
              }
            },
            listenWhen: (previous, current) =>
                (previous.loginResponse != current.loginResponse),
            builder: (context, state) {
              return Container(
                width: MediaQuery.of(context).size.width * 0.5,
                margin: const EdgeInsets.symmetric(vertical: 40),
                child: MaterialButton(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  color: context
                          .read<LoginBloc>()
                          .isValidRequest(state.loginRequest)
                      ? AppColors.blue
                      : AppColors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50),
                  ),
                  onPressed: () {
                    if (context
                        .read<LoginBloc>()
                        .isValidRequest(state.loginRequest)) {
                      context.read<LoginBloc>().add(
                          LoginSubmitEvent(loginRequest: state.loginRequest));
                    }
                  },
                  child: TextWidget(
                    text: context.l10n.login,
                    textAlign: TextAlign.center,
                    textSize: 20,
                    color: AppColors.white,
                  ),
                ),
              );
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () {
                  context.read<AuthBLoC>().add(const SelectLanguageEvent(
                      locale: Locale(Strings.en, '')));
                },
                child: TextWidget(
                  text: context.l10n.english,
                  color: AppColors.blue,
                  textSize: 20,
                ),
              ),
              InkWell(
                onTap: () {
                  context.read<AuthBLoC>().add(const SelectLanguageEvent(
                      locale: Locale(Strings.ja, '')));
                },
                child: TextWidget(
                  text: context.l10n.japanese,
                  color: AppColors.blue,
                  textSize: 20,
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}

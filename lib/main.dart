import 'package:bluestack_demo/l10n/translate.dart';
import 'package:bluestack_demo/resources%20/app_colors.dart';
import 'package:bluestack_demo/screens/dashboard/bloc/profile_bloc/profile_bloc.dart';
import 'package:bluestack_demo/screens/dashboard/bloc/tournaments_bloc/tournament_bloc.dart';
import 'package:bluestack_demo/screens/dashboard/dashboard_repository.dart';
import 'package:bluestack_demo/screens/dashboard/dashboard_screen.dart';
import 'package:bluestack_demo/screens/login/bloc/login_bloc.dart';
import 'package:bluestack_demo/screens/login/login_repository.dart';
import 'package:bluestack_demo/screens/login/login_screen.dart';
import 'package:bluestack_demo/screens/splash/bloc/auth_bloc.dart';
import 'package:bluestack_demo/screens/splash/splash.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MyApp(
    languageCode: 'getLanguageCode',
    loginRepo: LoginRepo(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key, required this.loginRepo, required this.languageCode})
      : super(key: key);
  final LoginRepo loginRepo;
  final String languageCode;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    return RepositoryProvider.value(
      value: loginRepo,
      child: BlocProvider(
        create: (context) {
          return AuthBLoC(repo: loginRepo, languageCode: languageCode);
        },
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({Key? key}) : super(key: key);

  @override
  _AppViewState createState() => _AppViewState();
// static _AppViewState? of(BuildContext context) => context.findAncestorStateOfType<_AppViewState>();

}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;

  @override
  Widget build(BuildContext context) {

    return BlocBuilder<AuthBLoC, AuthState>(
      buildWhen: (previous, current) => current is LanguageChangeState,
      builder: (context, state) {
        return MaterialApp(
          theme: ThemeData(
            primaryColor: AppColors.white,
            focusColor: AppColors.black,
          ),
          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          locale: state is LanguageChangeState
              ? state.locale
              : const Locale('en', ''),
          supportedLocales: const [
            Locale('en', ''),
            Locale('ja', ''),
          ],
          navigatorKey: _navigatorKey,
          builder: (context, child) {
            Translate().setContext(context);
            return BlocListener<AuthBLoC, AuthState>(
              listener: (context, state) {
                if (state is AuthStatusState) {
                  switch (state.authStatus) {
                    case AuthStatus.authenticated:
                      _navigator.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (cxt) {
                        return RepositoryProvider.value(
                          value: DashboardRepository(),
                          child: MultiBlocProvider(providers: [
                            BlocProvider<TournamentBLoC>(
                              create: (BuildContext context) => TournamentBLoC(
                                  dashboardRepository: RepositoryProvider.of<
                                      DashboardRepository>(context)),
                            ),
                            BlocProvider<ProfileBLoC>(
                              create: (BuildContext context) => ProfileBLoC(
                                  repo: RepositoryProvider.of<
                                      DashboardRepository>(context)),
                            ),
                          ], child: const DashboardScreen()),
                        );
                      }), (isRoute) => false);
                      break;
                    case AuthStatus.unauthenticated:
                      _navigator.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (cxt) {
                        return BlocProvider(
                            create: (context) {
                              return LoginBloc(
                                loginRepo:
                                    RepositoryProvider.of<LoginRepo>(context),
                              );
                            },
                            child: const LoginScreen());
                      }), (isRoute) => false);
                      break;
                    default:
                      _navigator.pushAndRemoveUntil(
                          MaterialPageRoute(builder: (cxt) {
                        return BlocProvider(
                            create: (context) {
                              return LoginBloc(
                                loginRepo:
                                    RepositoryProvider.of<LoginRepo>(context),
                              );
                            },
                            child: const LoginScreen());
                      }), (isRoute) => false);
                      break;
                  }
                }
              },
              child: child,
            );
          },
          onGenerateRoute: (_) => SplashPage.route(),
        );
      },
    );
  }
}



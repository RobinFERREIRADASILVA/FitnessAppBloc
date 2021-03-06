import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_login/home/view/home_page.dart';
import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:flutter_login/login/view/login_form.dart';
import 'package:flutter_login/login/view/login_page.dart';
import 'package:user_repository/user_repository.dart';

import 'splash/view/splash_page.dart';

class App extends StatelessWidget {
  const App({
    Key? key,
    required this.authenticationRepository,
    required this.userRepository,
  }) : super(key: key);

  final AuthenticationRepository authenticationRepository;
  final UserRepository userRepository;

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
        value: authenticationRepository,
        child: BlocProvider(
            create: (_) => AuthenticationBloc(
                authenticationRepository: authenticationRepository,
                userRepository: userRepository),
            child: MultiBlocProvider(
              providers: [
                BlocProvider(
                  create: (context) => LoginBloc(
                    authenticationRepository:
                        RepositoryProvider.of<AuthenticationRepository>(
                            context),
                  ),
                )
              ],
              child: AppView(),
            )));
  }
}

class AppView extends StatefulWidget {
  AppView({Key? key}) : super(key: key);

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState? get _navigator => _navigatorKey.currentState;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: _navigatorKey,
      initialRoute: '/',
      routes: {
        '/signup': (context) => LoginForm(),
      },
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationInitial>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  HomePage.route(),
                  (route) => false,
                );
                break;
              case AuthenticationStatus.unauthenticated:
                _navigator!.pushAndRemoveUntil<void>(
                  LoginPage.route(),
                  (route) => false,
                );
                break;
              default:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => SplashPage.route(),
    );
  }
}

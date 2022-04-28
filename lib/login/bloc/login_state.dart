part of 'login_bloc.dart';

class LoginState extends Equatable {
  const LoginState({
    this.status = FormzStatus.pure,
    this.username = const Username.pure(),
    this.password = const Password.pure(),
    this.screenView = '',
    this.user,
  });

  final FormzStatus status;
  final Username username;
  final Password password;
  final String screenView;
  final User? user;

  LoginState copyWith({
    FormzStatus? status,
    Username? username,
    Password? password,
    String? screenView,
    User? user,
  }) {
    return LoginState(
      status: status ?? this.status,
      username: username ?? this.username,
      password: password ?? this.password,
      screenView: screenView ?? this.screenView,
      user: user ?? this.user,
    );
  }

  @override
  List<Object> get props => [
        status,
        username,
        password,
        screenView,
        {user}
      ];
}

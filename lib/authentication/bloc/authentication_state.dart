part of 'authentication_bloc.dart';

abstract class AuthenticationState extends Equatable {
  @override
  List<Object> get props => [];
}

class AuthenticationInitial extends AuthenticationState {
  AuthenticationInitial._({
    this.status = AuthenticationStatus.unknown,
    this.user = User.empty,
  });

  AuthenticationInitial.unknow() : this._();

  AuthenticationInitial.authenticated(User user)
      : this._(status: AuthenticationStatus.authenticated, user: user);

  AuthenticationInitial.unauthenticated()
      : this._(status: AuthenticationStatus.unauthenticated);

  final AuthenticationStatus status;
  final User user;

  @override
  List<Object> get props => [status, user];
}

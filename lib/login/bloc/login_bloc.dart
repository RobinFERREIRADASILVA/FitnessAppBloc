import 'package:authentication_repository/authentication_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_login/authentication/bloc/authentication_bloc.dart';
import 'package:flutter_login/login/models/models.dart';
import 'package:flutter_login/login/models/username.dart';
import 'package:formz/formz.dart';
import 'package:user_repository/user_repository.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required AuthenticationRepository authenticationRepository,
  })  : _authenticationRepository = authenticationRepository,
        super(LoginState()) {
    on<LoginUsernameChanged>(_onUsernameChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<LoginSubmitted>(_onSubmitted);
    on<LoginSignUp>(_onSignUp);
    on<LoginScreenViewChanged>(_onChangeScreenView);
    on<LoginLoadUser>(_onLoadUser);
  }

  final AuthenticationRepository _authenticationRepository;

  void _onUsernameChanged(
    LoginUsernameChanged event,
    Emitter<LoginState> emit,
  ) {
    final username = Username.dirty(event.username);
    emit(state.copyWith(
        username: username,
        status: Formz.validate([state.password, username])));
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final password = Password.dirty(event.password);

    emit(state.copyWith(
        password: password,
        status: Formz.validate([password, state.username])));
  }

  void _onSubmitted(
    LoginSubmitted event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        await _authenticationRepository.logIn(
            email: state.username.value, password: state.password.value);
        emit(state.copyWith(status: FormzStatus.submissionSuccess));
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onChangeScreenView(
    LoginScreenViewChanged event,
    Emitter<LoginState> emit,
  ) {
    emit(state.copyWith(
      screenView: event.screenView,
    ));
  }

  void _onSignUp(
    LoginSignUp event,
    Emitter<LoginState> emit,
  ) async {
    if (state.status.isValidated) {
      emit(state.copyWith(status: FormzStatus.submissionInProgress));

      try {
        await _authenticationRepository.signUp(
            email: state.username.value, password: state.password.value);
      } catch (_) {
        emit(state.copyWith(status: FormzStatus.submissionFailure));
      }
    }
  }

  void _onLoadUser(
    LoginLoadUser event,
    Emitter<LoginState> emit,
  ) {
    print(event.user);
    emit(state.copyWith(user: event.user));
  }
}

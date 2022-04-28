import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';

enum AuthenticationStatus { unknown, authenticated, unauthenticated }

class AuthenticationRepository {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final _controller = StreamController<AuthenticationStatus>();

  Stream<AuthenticationStatus> get status async* {
    await Future<void>.delayed(const Duration(seconds: 1));

    yield AuthenticationStatus.unauthenticated;

    yield* _controller.stream;
  }

  Future<void> logIn({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _auth.signInWithEmailAndPassword(
        email: email, password: password);

    User? user = result.user;

    print(user);
    print(result);

    if (user != null) {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  Future<void> signUp({
    required String email,
    required String password,
  }) async {
    UserCredential result = await _auth.createUserWithEmailAndPassword(
        email: email, password: password);

    User? user = result.user;
    print('on passe au moins ici');

    print(user);

    if (user != null) {
      _controller.add(AuthenticationStatus.authenticated);
    }
  }

  void logOut() {
    _controller.add(AuthenticationStatus.unauthenticated);
  }

  void dispose() => _controller.close();
}

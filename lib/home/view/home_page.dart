import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/bloc/login_bloc.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    print('cest surement toi qui plante non ?');
    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      print(state);
      return Container(child: Text('bonsoir ${state.user}'));
    });
  }
}

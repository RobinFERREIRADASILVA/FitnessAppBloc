import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginChoice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(children: [
          Image.asset('images/home.jfif'),
          Positioned(
              top: 350,
              left: 0,
              right: 0,
              child: Text('Fitness App',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abrilFatface(
                      color: Colors.white, fontSize: 35)))
        ]),
        Expanded(
          child: Container(
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
                color: Colors.black, border: Border(top: BorderSide.none)),
            child: Column(children: [
              BlocBuilder<LoginBloc, LoginState>(
                  builder: (context, state) => (ElevatedButton(
                      onPressed: () {
                        context
                            .read<LoginBloc>()
                            .add(LoginScreenViewChanged('login'));

                        // Navigator.pushNamed(context, '/signup');
                        // stateAccess.changeRegisterState(false);

                        // Navigator.pushNamed(context, '/signup');
                      },
                      style: ElevatedButton.styleFrom(
                          onPrimary: Colors.indigo,
                          elevation: 4,
                          primary: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ),
                          padding: EdgeInsets.only(
                              top: 15,
                              bottom: 15,
                              left: MediaQuery.of(context).size.width / 2.8,
                              right: MediaQuery.of(context).size.width / 2.8)),
                      child: Text(
                        'Se connecter',
                        // style: GoogleFonts.robotoCondensed(
                        //     color: Colors.black, fontSize: 16)
                      )))),
              SizedBox(
                height: 5,
              ),
              BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
                print(state);
                return ElevatedButton(
                    onPressed: () {
                      // stateAccess.changeRegisterState(true);

                      context
                          .read<LoginBloc>()
                          .add(LoginScreenViewChanged('signup'));

                      // Navigator.pushNamed(context, '/signup');
                    },
                    style: ElevatedButton.styleFrom(
                        onPrimary: Colors.indigo,
                        elevation: 4,
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        padding: EdgeInsets.only(
                            top: 15,
                            bottom: 15,
                            left: MediaQuery.of(context).size.width / 2.6,
                            right: MediaQuery.of(context).size.width / 2.6)),
                    child: Text(
                      "S'inscrire",
                      // style: GoogleFonts.robotoCondensed(
                      //     color: Colors.black, fontSize: 16)
                    ));
              })
            ]),
          ),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:flutter_login/login/view/login_choice.dart';
import 'package:formz/formz.dart';

class LoginForm extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginBloc, LoginState>(listener: (context, state) {
      if (state.status.isSubmissionFailure) {
        ScaffoldMessenger.of(context)
          ..hideCurrentSnackBar()
          ..showSnackBar(
            const SnackBar(content: Text('Authentication Failure')),
          );
      }
    }, child: BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      print(state);
      if (state.screenView == '') {
        return LoginChoice();
      } else {
        return Container(
            decoration: const BoxDecoration(
                color: Colors.black, border: Border(top: BorderSide.none)),
            width: MediaQuery.of(context).size.width,
            child: Column(
              children: [
                Image.asset(
                  'images/logo.jpg',
                  width: MediaQuery.of(context).size.width,
                  fit: BoxFit.cover,
                  height: 400,
                  colorBlendMode: BlendMode.hardLight,
                ),
                Expanded(
                    child: SingleChildScrollView(
                        child: Column(
                  children: [
                    Form(
                        // key: formKey,
                        child: Column(
                      children: [
                        if (state.screenView == 'signup')
                          (Padding(
                            padding: const EdgeInsets.only(
                                top: 10, bottom: 10, left: 10, right: 10),
                            child: TextFormField(
                              // controller: nameController,
                              style: TextStyle(color: Colors.white),
                              decoration: const InputDecoration(
                                labelText: 'Nom',
                                hintStyle: TextStyle(color: Color(0xFF6a6b76)),
                                labelStyle: TextStyle(color: Color(0xFF6a6b76)),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF6a6b76), width: 1.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)),
                                  borderSide: BorderSide(
                                      color: Color(0xFF6a6b76), width: 1.0),
                                ),
                              ),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Veuillez rentrer un nom';
                                }
                                return null;
                              },
                            ),
                          )),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: TextFormField(
                            // controller: emailController,
                            style: TextStyle(color: Colors.white),
                            onChanged: (username) => {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginUsernameChanged(username))
                            },
                            decoration: InputDecoration(
                              labelText: 'Email',
                              errorText: state.username.invalid
                                  ? 'Mauvais email'
                                  : null,
                              hintStyle: TextStyle(color: Color(0xFF6a6b76)),
                              labelStyle: TextStyle(color: Color(0xFF6a6b76)),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Color(0xFF6a6b76), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Color(0xFF6a6b76), width: 1.0),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez rentrer un email';
                              }
                              return null;
                            },
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 10, bottom: 10, left: 10, right: 10),
                          child: TextFormField(
                            style: TextStyle(color: Colors.white),
                            onChanged: (password) => {
                              context
                                  .read<LoginBloc>()
                                  .add(LoginPasswordChanged(password))
                            },
                            // controller: passwordController,
                            obscureText: true,
                            decoration: InputDecoration(
                              errorText: state.password.invalid
                                  ? 'Mauvais mot de passe'
                                  : null,
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Color(0xFF6a6b76), width: 1.0),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)),
                                borderSide: BorderSide(
                                    color: Color(0xFF6a6b76), width: 1.0),
                              ),
                              labelText: 'Mot de passe',
                              hintStyle: TextStyle(color: Color(0xFF6a6b76)),
                              labelStyle: TextStyle(color: Color(0xFF6a6b76)),
                            ),
                            validator: (value) {
                              if (value == null ||
                                  value.isEmpty ||
                                  value.length < 6) {
                                return 'Veuillez rentrer un mot de passe';
                              }
                              return null;
                            },
                          ),
                        ),
                        // Text(error),
                        ElevatedButton(
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
                                    left:
                                        MediaQuery.of(context).size.width / 2.8,
                                    right: MediaQuery.of(context).size.width /
                                        2.8)),
                            onPressed: () async {
                              state.screenView == 'login'
                                  ? context
                                      .read<LoginBloc>()
                                      .add(LoginSubmitted())
                                  : context
                                      .read<LoginBloc>()
                                      .add(LoginSignUp());
                              // Validate returns true if the form is valid, or false otherwise.
                              // if (formKey.currentState!
                              //     .validate()) {
                              //   setState(() {
                              //     loading = true;
                              //   });
                              //   String password =
                              //       passwordController.value.text;
                              //   String email =
                              //       emailController.value.text;
                              //   String name =
                              //       nameController.value.text;
                              //   dynamic result = !state.register
                              //       ? await _auth.signIn(
                              //           email, password)
                              //       : await _auth.registerUser(
                              //           name, email, password);
                              //   print(result);

                              //   if (result == null) {
                              //     setState(() {
                              //       loading = false;
                              //       error =
                              //           'Please supply a valid email';
                              //     });
                              //   }
                              // }
                            },
                            child: Text(
                              state.screenView == 'login'
                                  ? 'Se connecter'
                                  : "S'inscrire",
                              style: TextStyle(color: Colors.black),
                            )),
                      ],
                    ))
                  ],
                )))
              ],
            ));
      }
    }));
  }
}

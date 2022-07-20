import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_login/login/bloc/login_bloc.dart';
import 'package:flutter_login/shared/AppBarWidget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:table_calendar/table_calendar.dart';

class HomePage extends StatelessWidget {
  static Route route() {
    return MaterialPageRoute<void>(builder: (_) => HomePage());
  }

  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return BlocBuilder<LoginBloc, LoginState>(builder: (context, state) {
      print(state.user);
      return Scaffold(
          // appBar: PreferredSize(
          //   child: AppBarWidget(title: 'home'),
          //   preferredSize: const Size.fromHeight(50),
          // ),
          body: SingleChildScrollView(
              child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Column(
          children: [
            Container(
              //apply margin and padding using Container Widget.
              margin: EdgeInsets.only(top: 70, bottom: 50),
              child: Text('Dépasser vos limites et suivez vos progrès',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.abrilFatface(
                      color: Colors.white, fontSize: 35)),
            ),
            TableCalendar(
              calendarFormat: CalendarFormat.week,
              firstDay: DateTime.utc(2010, 10, 16),
              lastDay: DateTime.utc(2030, 3, 14),
              focusedDay: DateTime.now(),
            ),
            Container(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                children: <Widget>[
                  Container(
                    height: 200,
                    width: 250,
                    child: Column(
                      children: [
                        Center(
                          child: Text('Vos séances',
                              textAlign: TextAlign.center,
                              style: GoogleFonts.abrilFatface(
                                  color: Colors.white, fontSize: 26)),
                        )
                      ],
                    ),
                    margin: EdgeInsets.only(right: 30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: AssetImage('images/perf.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                  Container(
                    height: 200,
                    width: 250,
                    margin: EdgeInsets.only(right: 30),
                    decoration: const BoxDecoration(
                        borderRadius: BorderRadius.all(Radius.circular(15)),
                        image: DecorationImage(
                          image: AssetImage('images/perf.jpg'),
                          fit: BoxFit.cover,
                        )),
                  ),
                ],
              ),
            )
          ],
        ),
      )));
    });
  }
}

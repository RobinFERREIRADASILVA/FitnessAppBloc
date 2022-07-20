import 'package:flutter/material.dart';

class AppBarWidget extends StatelessWidget {
  AppBarWidget({Key? key, required String title}) : super(key: key);

  String title = '';

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text('$title'),
      centerTitle: true,
    );
  }
}

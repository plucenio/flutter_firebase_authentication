import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        secondaryHeaderColor: Colors.cyan,
      ),
    ).modular();
  }
}

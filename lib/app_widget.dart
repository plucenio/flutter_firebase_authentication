import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:google_fonts/google_fonts.dart';

class AppWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Firebase Authentication',
      theme: ThemeData(
        primarySwatch: Colors.teal,
        secondaryHeaderColor: Colors.cyan,
        textTheme: Theme.of(context).textTheme.copyWith(
              bodyText2: Theme.of(context).textTheme.bodyText2.copyWith(
                    color: Colors.cyan,
                  ),
            ),
        fontFamily: GoogleFonts.roboto().fontFamily,
      ),
    ).modular();
  }
}

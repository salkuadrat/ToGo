import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import 'blocs/blocs.dart';
import 'view/home.dart';

void main() {
  runApp(
    BlocProvider(
      create: (_) => CartBloc(),
      child: App(),
    )
  );
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'ToGo BLoC',
      theme: ThemeData(
        primarySwatch: Colors.lightGreen,
        textTheme: GoogleFonts.sourceSansProTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: Home(),
    );
  }
}
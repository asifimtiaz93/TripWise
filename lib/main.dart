import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripwise/pages/navpages/main_page.dart';
import 'package:tripwise/pages/welcome_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'TripWise',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
                seedColor: Color.fromARGB(255, 3, 112, 255)),
            textTheme: GoogleFonts.mulishTextTheme(
              Theme.of(context).textTheme,
            )),
        home: const MainPage());
  }
}

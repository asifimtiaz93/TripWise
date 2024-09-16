import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tripwise/firebase_options.dart';
import 'package:tripwise/pages/navpages/main_page.dart';
import 'package:tripwise/pages/navpages/splash_screen.dart';
import 'package:tripwise/pages/welcome_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
    print('Firebase initialized successfully');
  } catch (e) {
    print('Firebase initialization failed: $e');
  }
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

        home: SplashScreen());
  }
}

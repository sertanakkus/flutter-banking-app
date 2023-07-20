import 'package:flutter/material.dart';

import 'screens/onboarding_screens/onboarding_page.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/services.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        textSelectionTheme: const TextSelectionThemeData(cursorColor: Colors.black54),
        inputDecorationTheme: const InputDecorationTheme(
          labelStyle: TextStyle(color: Colors.black),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.black54)),
        ),
        appBarTheme: const AppBarTheme(
          systemOverlayStyle: SystemUiOverlayStyle.dark,
          foregroundColor: Colors.black,
        ),
        colorScheme: const ColorScheme.light(),
      ),
      home: const OnboardingPage(),
    );
  }
}
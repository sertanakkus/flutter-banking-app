import 'package:banking_app/screens/main_page_controller.dart';
import 'package:banking_app/screens/onboarding_screens/onboarding_page.dart';
import 'package:banking_app/screens/send_money/success_screen.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:banking_app/models/user_model.dart';

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
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<UserModel>(create: (_) => (UserModel())),
      ],
      child: MaterialApp(
        title: 'Banking App',
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
        routes: {
          "/home": (context) => const MainPageController(),
          "/success-send-money": (context) => const SendMoneySuccessScreen(),
        },
      ),
    );
  }
}

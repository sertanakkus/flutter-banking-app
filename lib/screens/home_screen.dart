import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final String userId = ModalRoute.of(context)!.settings.arguments.toString();

    return Scaffold(
      body: Center(
        child: Text(userId),
      ),
    );
  }
}

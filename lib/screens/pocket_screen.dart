import 'package:flutter/material.dart';

class PocketScreen extends StatefulWidget {
  const PocketScreen({super.key});

  @override
  State<PocketScreen> createState() => _PocketScreenState();
}

class _PocketScreenState extends State<PocketScreen> {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Pocket'),
    );
  }
}

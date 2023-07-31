import 'package:banking_app/screens/history/empty_history.dart';
import 'package:banking_app/screens/history/information_history.dart';
import 'package:flutter/material.dart';

import '../../services/auth_service.dart';

class MainHistory extends StatefulWidget {
  const MainHistory({super.key});

  @override
  State<MainHistory> createState() => _MainHistoryState();
}

class _MainHistoryState extends State<MainHistory> {
  List<dynamic>? _history;

  @override
  void initState() {
    super.initState();
    _getHistory();
  }

  void _getHistory() async {
    final history = await AuthService().getHistory();

    setState(() {
      _history = history;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _history != null
        ? (_history!.isEmpty ? const EmptyHistory() : const HistoryInformation())
        : const Center(child: CircularProgressIndicator());
  }
}

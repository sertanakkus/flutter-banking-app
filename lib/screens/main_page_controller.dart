import 'package:banking_app/screens/pocket_screen.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainPageController extends StatefulWidget {
  const MainPageController({super.key});

  @override
  State<MainPageController> createState() => MainPageControllerState();
}

class MainPageControllerState extends State<MainPageController> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PocketScreen(),
    const PocketScreen(),
    const PocketScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _widgetOptions.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black26,
        showUnselectedLabels: true,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_filled),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.wallet),
            label: 'Pocket',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.inbox),
            label: 'Inbox',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: AppColors.baseColor,
        onTap: _onItemTapped,
      ),
    );
  }
}

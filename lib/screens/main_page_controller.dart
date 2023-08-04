import 'package:banking_app/profile.dart';
import 'package:banking_app/screens/pocket/pocket_main.dart';
import 'package:banking_app/utils/constants.dart';
import 'package:flutter/material.dart';

import 'home_screen.dart';

class MainPageController extends StatefulWidget {
  final int? index;
  const MainPageController({super.key, this.index});

  @override
  State<MainPageController> createState() => MainPageControllerState();
}

class MainPageControllerState extends State<MainPageController> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    const HomeScreen(),
    const PocketMainScreen(),
    const Center(
      child: Text('Inbox'),
    ),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();

    _selectedIndex = (widget.index ?? 0);
  }

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

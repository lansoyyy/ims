import 'package:flutter/material.dart';
import 'package:ims/screens/coach_appointment_screen.dart';
import 'package:ims/screens/coach_home_screen.dart';
import 'package:ims/screens/home_screen.dart';
import 'package:ims/screens/notif_screen.dart';
import 'package:ims/utlis/colors.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  var _currentIndex = 0;

  List tabs = [
    const HomeScreen(),
    const NotifScreen(),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tabs[_currentIndex],
      bottomNavigationBar: SalomonBottomBar(
        backgroundColor: primary,
        currentIndex: _currentIndex,
        onTap: (i) => setState(() => _currentIndex = i),
        items: [
          /// Home
          SalomonBottomBarItem(
            icon: Icon(
              Icons.home,
              color: _currentIndex == 0 ? Colors.white : Colors.black,
            ),
            title: const Text(
              "Home",
              style: TextStyle(fontFamily: 'Bold'),
            ),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.notifications),
            title: const Text(
              "Notifications",
              style: TextStyle(fontFamily: 'Bold'),
            ),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

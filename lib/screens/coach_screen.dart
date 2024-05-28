import 'package:flutter/material.dart';
import 'package:ims/screens/coach_home_screen.dart';
import 'package:ims/utlis/colors.dart';

import 'package:salomon_bottom_bar/salomon_bottom_bar.dart';

class CoachScreen extends StatefulWidget {
  const CoachScreen({super.key});

  @override
  State<CoachScreen> createState() => _CoachScreenState();
}

class _CoachScreenState extends State<CoachScreen> {
  var _currentIndex = 0;

  List tabs = [
    const CoachHomeScreen(),
    const SizedBox(),
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
              Icons.group_outlined,
              color: _currentIndex == 0 ? Colors.white : Colors.black,
            ),
            title: const Text(
              "Students",
              style: TextStyle(fontFamily: 'Bold'),
            ),
            selectedColor: Colors.white,
          ),
          SalomonBottomBarItem(
            icon: const Icon(Icons.calendar_month_outlined),
            title: const Text(
              "Appointment",
              style: TextStyle(fontFamily: 'Bold'),
            ),
            selectedColor: Colors.white,
          ),
        ],
      ),
    );
  }
}

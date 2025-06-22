import 'package:attireit/Presentation/askattireScreen.dart';
import 'package:attireit/Presentation/calendarScreen.dart';
import 'package:attireit/Presentation/homeScreen.dart';
import 'package:attireit/Presentation/profileScreen.dart';
import 'package:attireit/Presentation/wardrobeScreen.dart';
import 'package:attireit/utils/colors.dart';
import 'package:flutter/material.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({super.key});

  @override
  State<Mainscreen> createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    Homepage(),
    Wardrobescreen(),
    Calendarscreen(),
    Askattirescreen(),
    Profilescreen(),
  ];

  void _onTabTapped(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: IndexedStack(
        index: _selectedIndex,
        children: _screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: AppColors.primaryColor,
        currentIndex: _selectedIndex,
        onTap: _onTabTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: AppColors.secondaryColor,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: ImageIcon(
              AssetImage(
                  'lib/assets/images/homeicon.png'), // Update the path as needed
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('lib/assets/images/wardrobeicon.png')),
              label: 'Wardrobe'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('lib/assets/images/calendaricon.png')),
              label: 'Calendar'),
          BottomNavigationBarItem(
              icon:
                  ImageIcon(AssetImage('lib/assets/images/askattireicon.png')),
              label: 'Ask Attire'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('lib/assets/images/profileicon.png')),
              label: 'Profile'),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class BottomNavigationBarWidget extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  BottomNavigationBarWidget({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      selectedItemColor: Colors.green, // Set color for the selected icon
      unselectedItemColor: Colors.grey, // Set color for the unselected icon
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.shop),
          label: 'Shop',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.assignment),
          label: 'Tasks',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.monetization_on),
          label: 'EcoCoin',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.info),
          label: 'About',
        ),
      ],
    );
  }
}

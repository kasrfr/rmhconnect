import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/screens/residents/announcements_page.dart';
import 'package:rmhconnect/screens/residents/profile_page.dart';
import 'package:rmhconnect/screens/residents/residents_home.dart';

class NavigationPage extends StatefulWidget {
  const NavigationPage({super.key});

  @override
  State<NavigationPage> createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage> {
  int _selectedIndex = 0;

  static final List<Widget> _pages = <Widget>[
    ResidentsHome(),
    AnnouncementsPage(),
    ProfilePage()
  ];

  void _onItemTapped(int index){
    setState((){
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        selectedItemColor: backgroundColor,
        showSelectedLabels: true,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Announcements"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );

  }
}

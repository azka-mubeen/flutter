
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tailor_assistant/Tailor/EditProfile.dart';


import '../chat.dart';
import '../models/User.dart';
import 'home.dart';
import 'navigation/bottom_nav.dart';

class MyHomePage extends StatefulWidget {
  User userData;
  MyHomePage(this.userData, {super.key});
  @override
  _MyHomePageState createState() => _MyHomePageState(this.userData);
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  User userData;

  late List<Widget> _screens = [];

  _MyHomePageState(this.userData){
    _screens =[ HomePage(userData),
    const ChatScreen(),
    EditProfileScreen(userData)];
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex],
      bottomNavigationBar: MyBottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onTabTapped,
      ),
    );
  }
}
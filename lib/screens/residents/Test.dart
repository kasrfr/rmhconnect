import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/login_screen.dart';
import 'package:rmhconnect/SplashScreen.dart';
import 'package:rmhconnect/screens/Home.dart';
import 'package:rmhconnect/screens/admins/admin_announcements.dart';
import 'package:rmhconnect/screens/admins/admin_branch_deatils_screen.dart';
import 'package:rmhconnect/screens/admins/admin_events.dart';
import 'package:rmhconnect/screens/admins/admin_home.dart';
import 'package:rmhconnect/screens/admins/admin_navigation.dart';
import 'package:rmhconnect/screens/admins/super_admin/super_admin_navigation.dart';
import 'package:rmhconnect/screens/residents/announcements_page.dart';
import 'package:rmhconnect/screens/residents/navigation_page.dart';
import 'package:rmhconnect/screens/residents/profile_page.dart';
import 'package:rmhconnect/signup_screen.dart';
import 'package:rmhconnect/welcome.dart';
import 'package:rmhconnect/screens/admins/adminbranches.dart';
import 'package:rmhconnect/screens/admins/admin_members.dart';
import 'package:rmhconnect/theme.dart';
import 'package:rmhconnect/screens/residents/discovery.dart';
import 'package:rmhconnect/constants.dart';

class Test extends StatefulWidget {
  const Test({super.key});

  @override
  State<Test> createState() => _TestState();
}

class _TestState extends State<Test> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: backgroundColor,
        title: Text("Announcements", style: titling),
        centerTitle: true,
      ),
      body: ListView(
        children: [
          Discovery(),
          Discovery(),
          Discovery(),
          Discovery(),
          Discovery(),
        ]
      )
    );
  }
}

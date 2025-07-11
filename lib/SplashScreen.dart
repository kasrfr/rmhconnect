import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextStyle versionStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 32
  );
  final TextStyle titleStyle = TextStyle(
      fontSize: 32
  );
  @override
  void initState(){
    super.initState();
    init();
  }

  Future<void> init() async{
    await Future.delayed(const Duration(seconds: 3));
    // Navigator.pushReplacementNamed(context, '/welcome');

    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc =
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();
      final role = userDoc.data()?['role'] ?? 'patient';
      if (role == 'admin') {
        Navigator.pushReplacementNamed(context, '/admin_navigation');
      } else if (role == 'super_admin') {
        Navigator.pushReplacementNamed(context, '/super_admin_navigation');
      } else {
        Navigator.pushReplacementNamed(context, '/navigation_screen');
      }
    } else {
      Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body:
        SafeArea(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: Text(
                    "Ronald McDonald",
                        softWrap: true,
                        style: titleStyle
                  ),
                ),
                Text(
                    "House Charities",
                    softWrap: true,
                    style: titleStyle
                ),
                Logo(height: 350),
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                  child: Text(
                      "Version 1.0.0",
                      style: versionStyle
                  ),
                ),
              ]
            ),
          )
        )

    );
  }
}

giimport 'package:flutter/material.dart';
import 'package:rmhconnect/Login.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Text("yay", style: TextStyle(fontSize: 20))
    );
  }
}

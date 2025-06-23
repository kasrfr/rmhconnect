import 'package:flutter/material.dart';
import 'package:rmhconnect/Welcome.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/varries.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({super.key});

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(

        body: SafeArea(
          child: Center(
            child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25.0),
                    child: Logo(height: 350),
                  ),
                  Text("RMHC CONNECT", style: mytext),
                  SizedBox(
                    width: 200,
                    height: 20,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(

                      width: double.infinity,
                      child: OutlinedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, '/login_screen');
                        },
                        child: Text("Login"),
                      )
                    ),
                  ),
                  SizedBox(height: 20),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40.0),
                    child: SizedBox(
                        width: double.infinity,
                        child: OutlinedButton(
                          onPressed: () {
                            Navigator.pushNamed(context, '/signup_screen');
                          },
                          child: Text("Signup"),
                        )
                    ),
                  )
                ] //Children
            ),
          ),
        )
    );
  }
}

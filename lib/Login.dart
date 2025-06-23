import 'package:flutter/material.dart';
import 'package:rmhconnect/Login.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/varries.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Events.dart';
import 'package:rmhconnect/screens/logo.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
            title: const Text('Login'),
            backgroundColor: backgroundColor
        ),
        body: Form(
          key: _formKey,
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(30,00,30,0),
                child: Logo(height: 300),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                      helperText: 'Email'
                  ),
                  validator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return 'Please enter your email';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 80.0),
                child: TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                      helperText: 'Password'
                  ),
                  validator: (String? email) {
                    if (email == null || email.isEmpty) {
                      return 'We are sure you have a password';
                    }
                    return null;
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                child: ElevatedButton(
                  onPressed: () {
                    if (email == _emailController.text && password == _passwordController.text) {
                      signIn = true;
                      Navigator.pushNamed(context, '/profile');
                    }
                  },
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue
                  ),
                  child: const Text(
                      'Log In',
                      style: TextStyle(
                          color: Colors.white
                      )
                  ),
                ),
              ),

            ],
          ),
        )
    );
  }
}

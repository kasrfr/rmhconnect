import 'package:flutter/material.dart';
import 'package:rmhconnect/Login.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/screens/logo.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

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
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,0,0,0),
                  child: Logo(height: 300),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextFormField(
                    controller: _emailController,
                    decoration: const InputDecoration(
                      helperText: 'Email',
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
                  padding: const EdgeInsets.symmetric(horizontal: 0.0),
                  child: TextFormField(
                    controller: _passwordController,
                    obscureText: true,
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
          ),
        )
    );
  }
}

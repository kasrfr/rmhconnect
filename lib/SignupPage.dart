import 'package:flutter/material.dart';
import 'package:rmhconnect/varries.dart';

import 'constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {

    return Scaffold(
        appBar: AppBar(
            title: const Text('Sign Up'),
            backgroundColor: backgroundColor
        ),
        body: Padding(
            padding: const EdgeInsets.all(30),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 0,horizontal: 30),
                    child: Text(
                      "Welcome!",
                      style: TextStyle(
                          fontSize: 32
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 30,horizontal: 0),
                    child: Text(
                        "We are excited to have you!",
                        style: TextStyle(
                            fontSize: 24
                        )
                    ),
                  ),

                  TextFormField(
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
                  TextFormField(
                    controller: _passwordController,
                    decoration: const InputDecoration(
                        helperText: 'Password'
                    ),
                    obscureText: true,
                    validator: (String? password) {
                      if (password == null || password.length < 8) {
                        return 'Please enter a password with at least 8 characters.';
                      }
                      return null;
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    decoration: const InputDecoration(
                        helperText: 'Confirm password'
                    ),
                    obscureText: true,
                    validator: (String? password) {
                      if (password != _passwordController.text) {
                        return 'Passwords do not match.';
                      }
                      return null;
                    },
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          email = _emailController.text;
                          password = _passwordController.text;
                          signIn = true;
                          Navigator.pushNamed(context, '/profile');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue
                      ),
                      child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.white
                          )
                      ),
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
                      child: TextButton(
                          onPressed: (){
                            Navigator.pushNamed(context, '/login');
                          },
                          child: const Text(
                              "Not your first time? Log in!",
                              style: TextStyle(
                                  color: Colors.blue
                              )
                          )
                      )
                  )
                ],
              ),
            )
        )
    );

  }
}
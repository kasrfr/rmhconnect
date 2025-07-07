import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/login_screen.dart';
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
  String email = '';
  String password = '';
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
        body: SingleChildScrollView(
          child: Padding(
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
                      onChanged: (val) => setState(() => email = val)
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
                      onChanged: (val) => setState(() => password = val)
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 30, 0, 0),
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          try {
                            final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
                              email: email,
                              password: password,
                            );
                            final userDoc = await FirebaseFirestore.instance.collection('users').doc(credential.user!.uid).get();
                            final role = userDoc.data()?['role'] ?? 'patient';
                            if (role == 'admin') {
                              Navigator.pushReplacementNamed(context, '/admin_navigation');
                            } else if(role == 'super_admin'){
                              Navigator.pushReplacementNamed(context, '/super_admin_navigation');
                            } else {
                              Navigator.pushReplacementNamed(context, '/navigation_screen');
                            }
                          } catch (e) {
                            print(e);
                          }
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
          ),
        )
    );
  }
}

import 'package:flutter/material.dart';
import 'package:rmhconnect/SplashScreen.dart';
import 'package:rmhconnect/loginpage.dart';
import 'package:rmhconnect/Welcome.dart';
import 'package:rmhconnect/Home.dart';

Future<void> main() async{
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),

      initialRoute: '/',
      routes: {
        '/'/*name here before '*/: (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(),
      }
    );
  }
}

/*
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: const Placeholder(),
    );
  }
}
*/
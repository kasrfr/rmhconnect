import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Login.dart';
import 'package:rmhconnect/SplashScreen.dart';
import 'package:rmhconnect/Welcome.dart';
import 'package:rmhconnect/screens/Home.dart';
import 'package:rmhconnect/screens/Profile.dart';
import 'package:rmhconnect/screens/admins/admin_home.dart';
import 'package:rmhconnect/screens/residents/navigation_page.dart';
import 'package:rmhconnect/signup_screen.dart';
import 'firebase_options.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
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

      initialRoute: '/signup_screen', //'/',
      routes: {
        '/'/*name here before '*/: (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/home': (context) => HomePage(),
        '/profile': (context) => Profile(),
        '/login': (context) => LoginScreen(),
        '/signup': (context) => SignupPage(),
        '/navigation_screen': (context) => NavigationPage(),
        '/admin_home': (context) => AdminHome()
      }
    );
  }
}

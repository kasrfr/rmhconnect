import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/SplashScreen.dart';
import 'package:rmhconnect/firebase_options.dart';
import 'package:rmhconnect/loginpage.dart';
import 'package:rmhconnect/signup_screen.dart';
import 'package:rmhconnect/Welcome.dart';
import 'package:rmhconnect/screens/admins/admin_home.dart';
import 'package:rmhconnect/screens/residents/navigation_page.dart';


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

      initialRoute: '/',
      routes: {
        '/'/*name here before '*/: (context) => SplashScreen(),
        '/welcome': (context) => WelcomeScreen(),
        '/login_screen': (context) => LoginPage(),
        '/signup_screen': (context) => SignupPage(),
        '/admin_home': (context) => AdminHome(),
        '/navigation_screen': (context) => NavigationPage()
      }
    );
  }
}

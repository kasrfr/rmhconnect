import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Login.dart';
import 'package:rmhconnect/SplashScreen.dart';
import 'package:rmhconnect/screens/Home.dart';
import 'package:rmhconnect/screens/Profile.dart';
import 'package:rmhconnect/screens/admins/admin_home.dart';
import 'package:rmhconnect/screens/admins/adminnav.dart';
import 'package:rmhconnect/screens/residents/announcements_page.dart';
import 'package:rmhconnect/screens/residents/navigation_page.dart';
import 'package:rmhconnect/screens/residents/profile_page.dart';
import 'package:rmhconnect/screens/residents/residents_home.dart';
import 'package:rmhconnect/signup_screen.dart';
import 'package:rmhconnect/welcome.dart';
import 'firebase_options.dart';
import 'package:rmhconnect/screens/admins/adminbranches.dart';

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
        '/': (context) => SplashScreen(),
        '/welcome': (context) => WelcomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/home': (context) => ResidentsHome(),
        '/navigation_screen': (context) => NavigationPage(),
        '/announcements': (context) => AnnouncementsPage(),
        '/profile': (context) => ProfilePage(),
        '/admin_navigation': (context) => AdminNavigation(),
        '/admin_home': (context) => AdminHome(),
        '/admin_branch': (context) => Adminbranches(),
      }
    );
  }
}

import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/varries.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/Profile.dart';


class HomePage extends StatefulWidget {
  final int selectedIndex;
  const HomePage({super.key, this.selectedIndex = 0});



  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late int selectedIndex;

  @override
  void initState() {
    super.initState();
    selectedIndex = widget.selectedIndex; // get the starting index
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text("RMHC CONNECT", style: titling),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,30,0),
              child: Icon(Icons.notifications_outlined, color: Colors.white, size: 38),
            ),
          ]
      ),
      body: ListView(
      children: [
        Container(
          height: MediaQuery.of(context).size.height,
          color : Colors.white,
          child: Column(
                children: [
                    SizedBox(height: 10),
                    Text('Upcoming Events', style: titlingblck, textAlign: TextAlign.center),
                    SizedBox(height: 10),
                    Events(
          evname: "Event A",
          evdescrip: "Details about Event A",
          evtime: "2:00 PM",
          evdate: "June 25, 2025",
        ),
                    Events(
          evname: "Event B",
          evdescrip: "Details about Event B",
          evtime: "4:30 PM",
          evdate: "June 30, 2025",
        ),
                    Events(
          evname: "Event A",
          evdescrip: "Details about Event A",
          evtime: "2:00 PM",
          evdate: "June 25, 2025",
        ),
                ]
          )
        )
      ]
      ),
      backgroundColor : backgroundColor,

      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == 2 && signIn == false) {
            Navigator.pushNamed(context, '/welcome');
          }
          else if (index == 2 && signIn == true) {
            Navigator.pushNamed(context, '/profile');
          }
          if (index == 1) {
            Navigator.pushNamed(context, '/announcements');
          }
          else {
            setState(() {
              selectedIndex = index;
            });
          }
        },
        selectedItemColor: Colors.red,
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(icon: Icon(Icons.mail), label: "Announcements"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );

  }
}

import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/screens/Profile.dart';
import 'package:rmhconnect/screens/ProfilePhoto.dart';
import 'package:flutter/gestures.dart';

class Profile extends StatefulWidget {
  final int selectedIndex;
  const Profile({super.key, this.selectedIndex = 2});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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
          title: Text("My Profile", style: titling),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,30,0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE37575)
                      )
                  ),
                  Icon(Icons.person, color: Color(0xFFFFDEDE), size: 40),
                ],
              ),
            ),
          ]
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
            SizedBox(height: 40),
            Profilephoto(pfp: "https://media.cnn.com/api/v1/images/stellar/prod/160107100400-monkey-selfie.jpg?q=w_2912,h_1638,x_0,y_0,c_fill"),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8,0,0),
              child: Text(username, style: mytextmed),
            ),
            Text(role, style: mytextnormal),
            Text(email, style: TextStyle(fontSize: 18, decoration: TextDecoration.underline)),
            Text(location, style: mytextnormal),
            SizedBox(height: 30),
            GestureDetector(
              onTap: (){
                Navigator.pushNamed(context, '/directory');
              },
              child: Text("Branch Directory", style: TextStyle(fontSize:24, color: Colors.blue, fontWeight: FontWeight.bold)),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0,18.0,0,0),
              child: Text("My Events", style: titlingblck),
            ),
            ListView(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              children: [
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),
                Events(
                  evname: "Event A",
                  evdescrip: "Details about Event A",
                  evtime: "2:00 PM",
                  evdate: "June 25, 2025",
                ),

              ]
            )
            ]
          )
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
      currentIndex: selectedIndex,
      onTap: (index) {
        if (index == 0) {
          Navigator.pushNamed(context, '/home');
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

import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/varries.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';


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
  Widget _getBody() {
    switch (selectedIndex) {
      case 0:
        return ListView(
          children: [
            Container(
              height: 80,
              color: Colors.red,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("RMHC CONNECT", style: titling),
                  SizedBox(width: 10),
                  Icon(Icons.notifications, color: Colors.white, size: 32),
                ],
              ),
            ),
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
          ],
        );
      case 1:
        return Center(
          child: Text('Announcement Page Content', style: titlingblck),
        );
      case 2:
        return Scaffold(
            backgroundColor: backgroundColor,
            body:
            SafeArea(
                child: Center(
                  child: Column(
                    //mainAxisAlignment: MainAxisAlignment.center,
                      children:[
                        Padding(
                          padding: const EdgeInsets.only(top: 75),
                          child: Text(
                              "Ronald McDonald",
                              softWrap: true,
                              style: titleStyley
                          ),
                        ),
                        Text(
                            "House Charities",
                            softWrap: true,
                            style: titleStyley
                        ),
                        Logo(height: 350),
                        Spacer(flex: 1),
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                          child: Text(
                              "Version 1.0.0",
                              style: versionStyley
                          ),
                        ),
                      ]
                  ),
                )
            )
        );
      default:
        return Center(
          child: Text('Unknown Page Error', style: titlingblck),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor : Colors.white,
      body: SafeArea(
      child: _getBody()
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
        onTap: (index) {
          if (index == 2) {
            Navigator.pushNamed(context, '/welcome');
          }
          else if(index == 1){

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

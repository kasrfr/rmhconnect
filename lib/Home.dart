import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/varries.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Events.dart';


class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Icon(Icons.calendar_today_rounded);
    return Scaffold(
      backgroundColor : Colors.white,
      body: SafeArea(
      child: Center(
          child: Column(
            children: [
              Container(
              height:80,
              color: Colors.red,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("RMHC CONNECT", style: titling),
                      Icon(
                        Icons.notifications,
                        color: Colors.white,
                        size:32
                      )
                    ]
                )
              ),
              SizedBox(height: 10),
              Text('Upcoming Events', style: titlingblck),
              SizedBox(height: 10),
              Events(evname: "Event Name", evdescrip: "Event Description", evtime: "Event Time", evdate: "Event Date"),
              Events(evname: "Event Name", evdescrip: "Event Description", evtime: "Event Time", evdate: "Event Date")
              ],
          ),
        ),
      )
    );
  }
}

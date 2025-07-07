import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/residents/org_get_info.dart';

class ResidentsHome extends StatefulWidget {
  const ResidentsHome({super.key});

  @override
  State<ResidentsHome> createState() => _ResidentsHomeState();
}

class _ResidentsHomeState extends State<ResidentsHome> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: backgroundColor,
          automaticallyImplyLeading: false,
          title: Text("RMHC CONNECT", style: titling),
          centerTitle: true,
          // actions: [
          //   Padding(
          //     padding: const EdgeInsets.fromLTRB(0,0,30,0),
          //     child: Icon(Icons.notifications, color: Colors.white, size: 38),
          //   ),
          // ]
      ),
      body: SingleChildScrollView(
        child: Column(
          children:[
            Text("Upcoming Events", style: mytextmed),
            OrgGetInfo()
          ]
        )
      )
    );
  }
}

import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/screens/logo.dart';

class AdminBranchDeatils extends StatefulWidget {
  final String name;
  final String location;
  const AdminBranchDeatils({super.key, required this.name, required this.location,});

  @override
  State<AdminBranchDeatils> createState() => _AdminBranchDeatilsState();
}

class _AdminBranchDeatilsState extends State<AdminBranchDeatils> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Branch Details", style: titling),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: const Color(0xFFFFDEDE),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(110,20, 110,20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                      Text(widget.location, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                    ]
                  ),
                )
              ),
              ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: const Color(0xFFFFDEDE),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.check, color: Colors.red, size: 40),
                            SizedBox(height: 20),
                            Text("Announcements", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ]
                      ),
                    )
                ),
                Card(
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(25.0),
                    ),
                    color: const Color(0xFFFFDEDE),
                    child: Padding(
                      padding: const EdgeInsets.all(32.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Icon(Icons.calendar_month, color: Colors.red, size: 40),
                            SizedBox(height: 20),
                            Text("          Events         ", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                          ]
                      ),
                    )
                ),
              ]
            ),
            SizedBox(height: 20),
            GestureDetector(
              onTap: () {
                Navigator.pushNamed(context, '/admin_members');
              },
              child: Card(
                clipBehavior: Clip.antiAlias,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25.0),
                ),
                color: const Color(0xFFFFDEDE),
                child: Padding(
                  padding: const EdgeInsets.all(32.0),
                  child: Column(
                    children: [
                      Icon(Icons.group, color: Colors.red, size: 40),
                      SizedBox(height: 20),
                      Text("        Members       ", style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold)),
                    ]
                  ),
                )
              ),
            )
          ]
        )
      )
    );
  }
}

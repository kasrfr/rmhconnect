import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/varries.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/Profile.dart';
import 'package:rmhconnect/Announceinfo.dart';

class Announcements extends StatefulWidget {
  const Announcements({super.key});

  @override
  State<Announcements> createState() => _AnnouncementsState();
}

class _AnnouncementsState extends State<Announcements> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: backgroundColor,
          title: Text("Announcements", style: titling),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,28.0,0),
              child: Icon(Icons.notifications_outlined, color: Colors.white, size: 38),
            )
          ],
        ),
        body: ListView(
          children:[
            Padding(
              padding: const EdgeInsets.fromLTRB(0,8.0,0,0),
              child: Center(child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (){
                      showDialog(
                        context: context,
                        builder: (_) => AlertDialog(
                          title: Text("My Branches"),
                          content: Text(mebranch),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: Text("Close"),
                            )
                          ],
                        ),
                      );
                    },
                    child: Text("My Branches", style: TextStyle(fontSize:24, color: Colors.blue, fontWeight: FontWeight.bold)),
                  )
                ],
              )),
            ),
            Announceinfo(ppfp: "https://ichef.bbci.co.uk/images/ic/1024xn/p05clv0v.jpg", pname: "Joe Gargery", branch: "Springfield", ptext: "Banana Eating Contest tomorrow from seven thirty till eight thirty", pdate: "January 18th", ptime: "12:47"),

          ]
        )
    );
  }
}

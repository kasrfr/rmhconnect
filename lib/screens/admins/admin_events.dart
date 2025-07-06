import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/screens/admins/admin_get_events.dart';

class AdminEvents extends StatefulWidget {
  final String orgName;
  const AdminEvents({super.key, required this.orgName});

  @override
  State<AdminEvents> createState() => _AdminEventsState();
}

class _AdminEventsState extends State<AdminEvents> {
  late TextEditingController namecontrol = TextEditingController();
  late TextEditingController descripcontrol = TextEditingController();

  void _createEvents(String orgName, String title, String description) async {
    try {
      final orgQuery = await FirebaseFirestore.instance
          .collection('organizations')
          .where('name', isEqualTo: orgName)
          .limit(1)
          .get();

      if (orgQuery.docs.isEmpty) {
        throw Exception("Organization '$orgName' not found.");
      }

      final orgDocId = orgQuery.docs.first.id;

      final now = DateTime.now();
      final timestamp = Timestamp.fromDate(now);

      await FirebaseFirestore.instance
          .collection('organizations')
          .doc(orgDocId)
          .collection('activities')
          .add({
        'title': title,
        'description': description,
        'dateTime': timestamp,
      });

      print("Activity added successfully.");
    } catch (e) {
      print("Failed to add activity: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("RMHC Connect", style: titling),
        centerTitle: true,
      ),

      body: Center(
          child: Column(
              children: [
                Text("Upcoming Events", style: titling),
                AdminGetEvents(orgName: widget.orgName)
              ]
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                    title: Text("Create New Event"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: namecontrol,
                          decoration: InputDecoration(
                            labelText: "New Event Name",
                          ),
                        ),
                        SizedBox(height: 20),
                        TextField(
                          controller: descripcontrol,
                          decoration: InputDecoration(
                            labelText: "New Event Location",
                          ),
                        ),
                        SizedBox(height: 20),
                        Row(
                          children: [
                            OutlinedButton(
                              onPressed: () {
                                Navigator.pop(context);
                                namecontrol.clear();
                                descripcontrol.clear();
                              },
                              child: Text("Cancel"),
                            ),
                            SizedBox(width: 20),
                            OutlinedButton(
                              onPressed: () {
                                setState(() {
                                  nbname = namecontrol.text;
                                  nbloc = descripcontrol.text;
                                  namecontrol.clear();
                                  descripcontrol.clear();
                                });
                                _createEvents(widget.orgName, nbname, nbloc);
                                Navigator.pop(context);

                              },
                              child: Text("Create"),
                            ),

                          ],
                        )
                      ],
                    )
                );
              }
          );
        },
        child: Icon(Icons.add),
      )
    );
  }
}

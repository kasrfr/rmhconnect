import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';

class AdminHome extends StatefulWidget {
  const AdminHome({super.key});

  @override
  State<AdminHome> createState() => _AdminHomeState();
}

class _AdminHomeState extends State<AdminHome> {
  late TextEditingController namecontrol = TextEditingController();
  late TextEditingController descripcontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("RMHC Connect", style: titling),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
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
        ),
      body: Center(
        child: Column(
          children: [
            Text("Upcoming Events", style: titling),
            Events(
              evname: "Event A",
              evdescrip: "Details about Event A",
              evtime: "2:00 PM",
              evdate: "June 25, 2025",
            ),

          ]
        )
      )
    );
  }
}

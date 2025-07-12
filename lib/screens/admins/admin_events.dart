import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
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

  late DateTime _selectedDate;
  late TimeOfDay _selectedTime;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _selectedDate = now;
    _selectedTime = TimeOfDay(hour: now.hour, minute: now.minute);
  }

  void _createEvents(String orgName, String title, String description, DateTime date, TimeOfDay time) async {
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

      final combinedDateTime = DateTime(
        date.year,
        date.month,
        date.day,
        time.hour,
        time.minute,
      );
      final timestamp = Timestamp.fromDate(combinedDateTime);

      final eventRef = await FirebaseFirestore.instance
          .collection('organizations')
          .doc(orgDocId)
          .collection('activities')
          .add({
        'title': title,
        'description': description,
        'dateTime': timestamp,
      });
      await eventRef.update({'id': eventRef.id});
      print("Activity added successfully.");
    } catch (e) {
      print("Failed to add activity: $e");
    }
  }



  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(Duration(days: 365)),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );
    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(widget.orgName, style: titling),
        centerTitle: true,
      ),

      body: Center(
          child: SingleChildScrollView(
            child: Column(
                children: [
                  Text("Upcoming Events", style: mytextmed),
                  AdminGetEvents(orgName: widget.orgName)
                ]
            ),
          )
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return StatefulBuilder(
                builder: (BuildContext context, void Function(void Function()) setDialogState) {
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
                        Row(
                          children: [
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () async {
                                  final picked = await showDatePicker(
                                    context: context,
                                    initialDate: _selectedDate,
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime.now().add(Duration(days: 365)),
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _selectedDate = picked;
                                    });
                                    setDialogState(() {});
                                  }
                                },
                                icon: Icon(Icons.calendar_today),
                                label: Text(
                                  DateFormat('MMM d, yyyy').format(_selectedDate),
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextButton.icon(
                                onPressed: () async {
                                  final picked = await showTimePicker(
                                    context: context,
                                    initialTime: _selectedTime,
                                  );
                                  if (picked != null) {
                                    setState(() {
                                      _selectedTime = picked;
                                    });
                                    setDialogState(() {}); // Force dialog to rebuild
                                  }
                                },
                                icon: Icon(Icons.access_time),
                                label: Text(_selectedTime.format(context)),
                              ),
                            ),
                          ],
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
                            Spacer(),
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
                                _createEvents(widget.orgName, nbname, nbloc, _selectedDate, _selectedTime);
                                Navigator.pop(context);
                              },
                              child: Text("Create"),
                            ),
                          ],
                        )
                      ],
                    ),
                  );
                },
              );
            },
          );

        },
        child: Icon(Icons.add),
      )
    );
  }
}

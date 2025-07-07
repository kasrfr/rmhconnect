import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';

class Events extends StatelessWidget {
  final String eventID;
  final String evname;
  final String evdescrip;
  final String evtime;
  final String evdate;
  final String orgName;
  const Events({super.key, required this.eventID, required this.orgName, required this.evname, required this.evdescrip, required this.evtime, required this.evdate});

  Future<void> deleteEventByUid(String orgName, String uid) async {
    try {
      final orgQuery = await FirebaseFirestore.instance
          .collection('organizations')
          .where('name', isEqualTo: orgName)
          .limit(1)
          .get();

      if (orgQuery.docs.isEmpty) {
        print("No events found with name: $orgName");
        return;
      }

      final orgId = orgQuery.docs.first.id;

      final eventRef = FirebaseFirestore.instance
          .collection('organizations')
          .doc(orgId)
          .collection('activities')
          .doc(uid);

      final docSnapshot = await eventRef.get();

      if (docSnapshot.exists) {
        await eventRef.delete();
        print("Event with UID '$uid' deleted successfully from organization '$orgName'.");
      } else {
        print("No event found with UID: $uid under organization: $orgName");
      }
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  Future<bool?> showDeleteConfirmationDialog(BuildContext context, String orgName, String uid) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Event Deletion"),
        content: const Text("Are you sure you want to delete this event?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await deleteEventByUid(orgName, uid);
              Navigator.of(context).pop(true);
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete event"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(height:25),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Color(0xFFFFDEDE),
            elevation: 8,
            child:ExpansionTile(
                leading: Icon(Icons.calendar_today_rounded),
                title: Text(evname),
                subtitle: Text(evdate + "    " + evtime),
                trailing: GestureDetector(
                  onTap: () async {
                    await showDeleteConfirmationDialog(context, orgName, eventID);
                  },
                  child: const Icon(Icons.delete, color: Colors.red, size: 30),
                ),
                children: [
                  ListTile(
                    title: Text('Description', textAlign: TextAlign.center, style: mytextred),
                    subtitle: Text(evdescrip),
                  )
                ]
            )
          ),
        ]
      )
    );
  }
}

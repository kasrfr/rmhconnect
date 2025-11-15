import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/theme.dart';

enum SampleItem { itemOne, itemTwo, itemThree }

class Events extends StatefulWidget {
  final String eventID;
  final String evname;
  final String evdescrip;
  final String evtime;
  final String evdate;
  final String orgName;

  const Events({
    super.key,
    required this.eventID,
    required this.orgName,
    required this.evname,
    required this.evdescrip,
    required this.evtime,
    required this.evdate,
  });

  @override
  State<Events> createState() => _EventsState();
}

class _EventsState extends State<Events> {
  SampleItem? selectedItem;

  Future<void> deleteEventByUid(String orgName, String uid) async {
    try {
      final orgQuery = await FirebaseFirestore.instance
          .collection('organizations')
          .where('name', isEqualTo: orgName)
          .limit(1)
          .get();

      if (orgQuery.docs.isEmpty) {
        print("No organization found with name: $orgName");
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
        print("Event deleted successfully");
      } else {
        print("Event not found");
      }
    } catch (e) {
      print("Error deleting event: $e");
    }
  }

  Future<bool?> showDeleteConfirmationDialog(
      BuildContext context, String orgName, String uid) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Confirm Event Deletion"),
        content:
        const Text("Are you sure you want to delete this event permanently?"),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel"),
          ),
          TextButton(
            onPressed: () async {
              await deleteEventByUid(orgName, uid);
              Navigator.of(context).pop(true);

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Event deleted successfully "),
                ),
              );
            },
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            child: const Text("Delete"),
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
          const SizedBox(height: 25),
          Card(
            clipBehavior: Clip.antiAlias,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            elevation: 8,
            color: CharityConnectTheme.cardColor,
            child: ExpansionTile(
              leading: const Icon(Icons.calendar_today_rounded),
              title: Text(widget.evname),
              subtitle: Text('${widget.evdate}    ${widget.evtime}'),
              trailing: PopupMenuButton<SampleItem>(
                icon: const Icon(Icons.more_horiz,
                    color: Colors.black, size: 30),
                onSelected: (SampleItem item) async {
                  if (item == SampleItem.itemThree) {
                    bool? deleted = await showDeleteConfirmationDialog(
                        context, widget.orgName, widget.eventID);
                    if (deleted == true) {
                      setState(() {}); // Refresh UI after delete
                    }
                  }
                  if (item == SampleItem.itemTwo) {

                  }
                },
                itemBuilder: (BuildContext context) =>
                <PopupMenuEntry<SampleItem>>[
                  const PopupMenuItem(
                    value: SampleItem.itemOne,
                    child: Text('Edit'),
                  ),
                  const PopupMenuItem(
                    value: SampleItem.itemTwo,
                    child: Text('View Participants'),
                  ),
                  const PopupMenuItem(
                    value: SampleItem.itemThree,
                    child: Text('Delete'),
                  ),
                ],
              ),
              children: [
                ListTile(
                  title: const Text(
                    'Description',
                    textAlign: TextAlign.center,
                    style: TextStyle(color: Colors.red),
                  ),
                  subtitle: Text(widget.evdescrip),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

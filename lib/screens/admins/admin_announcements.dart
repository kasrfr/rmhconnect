import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmhconnect/constants.dart';

class AdminAnnouncements extends StatefulWidget {
  final String orgName;
  const AdminAnnouncements({super.key, required this.orgName});

  @override
  State<AdminAnnouncements> createState() => _AdminAnnouncementsState();
}

class _AdminAnnouncementsState extends State<AdminAnnouncements> {
  late TextEditingController namecontrol = TextEditingController();
  late TextEditingController descripcontrol = TextEditingController();

  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    final orgQuery = await FirebaseFirestore.instance
        .collection('organizations')
        .where('name', isEqualTo: widget.orgName)
        .limit(1)
        .get();

    if (orgQuery.docs.isEmpty) {
      throw Exception("No organization found with name: ${widget.orgName}");
    }

    final orgDocId = orgQuery.docs.first.id;

    final announcementsSnapshot = await FirebaseFirestore.instance
        .collection('organizations')
        .doc(orgDocId)
        .collection('announcements')
        .orderBy('timestamp', descending: true)
        .get();

    return announcementsSnapshot.docs.map((doc) => doc.data()).toList();
  }

  void _createAnnouncement(String orgName, String description, String url) async {
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
          .collection('announcements')
          .add({
        'description': description,
        'url': url,
        'timestamp': timestamp,
      });

      print("Announcement added successfully.");
    } catch (e) {
      print("Failed to add announcement: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text(widget.orgName, style: titling),
        centerTitle: true
      ),
      body: Column(
        children: [
          Text("Announcements", style: mytextmed),
          Expanded(
            child: FutureBuilder<List<Map<String, dynamic>>>(
              future: fetchAnnouncements(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }

                final announcements = snapshot.data ?? [];

                if (announcements.isEmpty) {
                  return const Center(child: Text('No announcements available'));
                }

                return ListView.builder(
                  itemCount: announcements.length,
                  itemBuilder: (context, index) {
                    final item = announcements[index];
                    // final imgUrl = item['url'];
                    final imgUrl = "https://e7.pngegg.com/pngimages/981/645/png-clipart-default-profile-united-states-computer-icons-desktop-free-high-quality-person-icon-miscellaneous-silhouette.png";
                    final description = item['description'];
                    final timestamp = item['timestamp'] as Timestamp?;
                    final date = timestamp?.toDate();

                    return ListTile(
                      leading: imgUrl != null
                          // ? Image.network(imgUrl, width: 60, fit: BoxFit.cover)
                          ? Image.asset('assets/images/person-icon.png')
                          : null,
                      title: Text(description ?? 'No description'),
                      subtitle: Text(
                        date != null
                            ? DateFormat.yMMMd().add_jm().format(date)
                            : 'No timestamp',
                      ),
                      onTap: () {},
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: backgroundColor,
        onPressed: (){
          showDialog(
              context: context,
              builder: (BuildContext context){
                return AlertDialog(
                    title: Text("Add Announcement"),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        TextField(
                          controller: descripcontrol,
                          decoration: InputDecoration(
                            labelText: "Description",
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
                                _createAnnouncement(
                                  widget.orgName,
                                  nbloc,
                                  "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTLn2vN-qAufnhM8t2e4OkZ6-m3Md6_Gk9B7g&s"
                                );
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
    );
  }
}

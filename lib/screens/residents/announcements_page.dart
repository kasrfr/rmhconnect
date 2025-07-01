import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmhconnect/constants.dart';


class AnnouncementsPage extends StatefulWidget {
  const AnnouncementsPage({super.key});

  @override
  State<AnnouncementsPage> createState() => _AnnouncementsPageState();
}

class _AnnouncementsPageState extends State<AnnouncementsPage> {

  Future<List<Map<String, dynamic>>> fetchAnnouncements() async {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception("User not logged in");
    }

    final userDoc = await FirebaseFirestore.instance
        .collection('users')
        .doc(user.uid)
        .get();

    final location = userDoc.data()?['location'];
    if (location == null) {
      throw Exception("User does not have a location set");
    }

    final orgQuery = await FirebaseFirestore.instance
        .collection('organizations')
        .where('name', isEqualTo: location)
        .limit(1)
        .get();

    if (orgQuery.docs.isEmpty) {
      throw Exception("No organization found with name: $location");
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: backgroundColor,
          title: Text("My Profile", style: titling),
          centerTitle: true,
          actions: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0,0,30,0),
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                      width: 40,
                      height: 40,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Color(0xFFE37575)
                      )
                  ),
                  Icon(Icons.person, color: Color(0xFFFFDEDE), size: 40),
                ],
              ),
            ),
          ]
      ),

      body: Column(
        children: [
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
                    final imgUrl = item['url'];
                    final description = item['description'];
                    final timestamp = item['timestamp'] as Timestamp?;
                    final date = timestamp?.toDate();

                    return ListTile(
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


    );
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class OrgGetInfo extends StatelessWidget {
  const OrgGetInfo({super.key});

  String _formatDateTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('MMM d, yyyy · h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DocumentSnapshot>(
      future: FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get(),
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (!userSnapshot.hasData || !userSnapshot.data!.exists) {
          return const Center(child: Text("User data not found"));
        }

        final userData = userSnapshot.data!.data() as Map<String, dynamic>;
        final location = userData['location'];

        if (location == null) {
          return const Center(child: Text("No location set for user"));
        }

        return StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('organizations')
              .where('name', isEqualTo: location)
              .snapshots(),
          builder: (context, orgSnapshot) {
            if (!orgSnapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            final organizations = orgSnapshot.data!.docs;
            if (organizations.isEmpty) {
              return const Center(child: Text("No organization found for your location"));
            }

            // Assuming only one org per name
            final orgDoc = organizations.first;

            return FutureBuilder<List<Map<String, dynamic>>>(
              future: FirebaseFirestore.instance
                  .collection('organizations')
                  .doc(orgDoc.id)
                  .collection('activities')
                  .where('dateTime', isGreaterThan: Timestamp.now())
                  .orderBy('dateTime')
                  .get()
                  .then((snapshot) {
                final activities = snapshot.docs.map((doc) {
                  return {
                    'id': doc.id,
                    'orgID': orgDoc.id,
                    'orgName': orgDoc['name'] ?? 'Organization',
                    ...doc.data(),
                  };
                }).toList();
                return activities;
              }),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final allActivities = snapshot.data!;
                if (allActivities.isEmpty) {
                  return const Center(child: Text('No upcoming activities'));
                }

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 1, // Only one org
                  itemBuilder: (context, index) {
                    final activities = allActivities;
                    final orgName = activities.first['orgName'] as String;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Text(orgName),
                        ),
                        ...activities.map((activity) {
                          return Card(
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(16),
                            ),
                            margin: const EdgeInsets.only(bottom: 16),
                            child: ExpansionTile(
                              leading: const Icon(Icons.event),
                              title: Text(activity['title'] ?? 'Activity'),
                              subtitle: activity['dateTime'] != null
                                  ? Text(_formatDateTime(activity['dateTime'] as Timestamp))
                                  : null,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(16),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Text("Description:"),
                                      const SizedBox(height: 8),
                                      Text(activity['description'] ?? 'No description provided'),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ],
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}

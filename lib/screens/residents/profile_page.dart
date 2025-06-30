import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/ProfilePhoto.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool informationLoaded = false;
  User? user;
  String name = '';
  String role = '';
  String email = '';
  String location = '';

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    init();
  }

  Future<void> init() async{
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      final userDoc = await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .get();

      setState(() {
        try{
          name = userDoc['name'];
          role = userDoc['role'];
          email = userDoc['email'];
          location = userDoc['location'];
        }catch(e){
          name = '';
          role = '';
          email = '';
          location = '';
        }
        informationLoaded = true;
      });
    }

  }

  void _showSettingsMenu() async {
    final action = await showModalBottomSheet<String>(
      context: context,
      builder: (context) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () => Navigator.pop(context, 'logout'),
            )
          ],
        ),
      ),
    );
    if (action == 'logout') {
      await FirebaseAuth.instance.signOut();
      if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
    }
  }

  String _formatDateTime(Timestamp timestamp) {
    final date = timestamp.toDate();
    return DateFormat('MMM d, yyyy · h:mm a').format(date);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                  IconButton(icon: Icon(Icons.settings), onPressed: _showSettingsMenu),
                ],
              ),
            ),
          ]
      ),
      body: Center(
          child: Column(
            children: [
              Profilephoto(pfp: "https://media.cnn.com/api/v1/images/stellar/prod/160107100400-monkey-selfie.jpg?q=w_2912,h_1638,x_0,y_0,c_fill"),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,8,0,0),
                child: Text(name, style: mytextmed),
              ),

              informationLoaded ?
                Column(
                  children: [
                    Text(role, style: mytextnormal),
                    Text(email, style: TextStyle(fontSize: 18, decoration: TextDecoration.underline)),
                    Text(location, style: mytextnormal),
                  ],
                )
              : Center(child: CircularProgressIndicator()),

              SizedBox(height: 30),
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/directory');
                },
                child: Text("Branch Directory", style: TextStyle(fontSize:24, color: Colors.blue, fontWeight: FontWeight.bold)),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0,18.0,0,0),
                child: Text("My Events", style: titlingblck),
              ),
              SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>( //updates based on snapshot
                        stream: FirebaseFirestore.instance
                            .collection('organizations')
                            .snapshots(),
                        builder: (context, orgSnapshot){ // orgSnapshot original var
                          //
                          if (!orgSnapshot.hasData){
                            return const Center(child: CircularProgressIndicator()); // there is no data
                          }
                          final organizations = orgSnapshot.data!.docs; // accept null val
                          if (organizations.isEmpty){
                            return Center(
                                child: Column(
                                    children: [
                                      Text("No organization found"),
                                    ]
                                )
                            );
                          }
                          return FutureBuilder<List<Map<String, dynamic>>>( // expect a list mapped as string and dynamic any type
                              future: Future.wait(
                                organizations.map((org) async { // org new var + async check
                                  final orgData = org.data() as Map<String, dynamic>;
                                  final activitiesSnapshot = await FirebaseFirestore
                                      .instance // await asynchronous firebase
                                      .collection(
                                      'organizations') // check in orgs subcollection
                                      .doc(org.id) // check individ IDs
                                      .collection(
                                      'activities') // continue w activs subcoll
                                      .where('dateTime',
                                      isGreaterThan: Timestamp.now()) // future only
                                      .orderBy('dateTime')
                                      .get();
                                  final activities = activitiesSnapshot.docs
                                      .map((doc) =>
                                  {
                                    // give map what's inside of {}
                                    'id:': doc.id,
                                    'orgID': org.id,
                                    'orgName': orgData['name'] ?? 'Organization',
                                    // if null, then give "Organization" by default
                                    ...doc.data()
                                    // map into activities (... = operation) into list/spread of widgets
                                  })
                                      .toList();
                                  return activities;
                                }),
                              ).then((allActivities) /* new var*/ {
                                //flatten/sort by date
                                final flattenedActivities = allActivities
                                    .expand((activities) => activities)
                                    .toList() // turn into list
                                  ..sort((a,b){
                                    final aDate = (a['dateTime'] as Timestamp).toDate();
                                    final bDate = (b['dateTime'] as Timestamp).toDate();
                                    return aDate.compareTo(bDate);
                                  });
                                return flattenedActivities;
                              }),
                              builder: (context, snapshot){
                                if(!snapshot.hasData) {
                                  return const Center(child: CircularProgressIndicator());
                                }
                                final allActivities = snapshot.data!; // ! = null is acceptable
                                if(allActivities.isEmpty){
                                  return Center(
                                      child: Column(
                                          children: [
                                            Text('No upcoming activities')
                                          ]
                                      )
                                  );
                                }

                                // group activs by org
                                final activitiesByOrg = <String, List<Map<String, dynamic>>>{};
                                for (final activity in allActivities) {
                                  final orgID = activity['orgID'] as String;
                                  activitiesByOrg.putIfAbsent(orgID, () => []).add(activity);
                                }

                                return ListView.builder( // dynamically bulids page based on listview
                                  shrinkWrap: true, // expect lots of information
                                  physics: const NeverScrollableScrollPhysics(), // don't want to scroll while loading
                                  itemCount: activitiesByOrg.length,
                                  itemBuilder: (context, index) {
                                    final orgID = activitiesByOrg.keys.elementAt(index);
                                    final activities = activitiesByOrg[orgID]!;
                                    final orgName = activities.first['orgName'] as String;
                                    // ^ get information
                                    return Column( // build information on page
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                                          child: Text(orgName),
                                        ),
                                        ...activities.map((activity) {
                                          return Card( // create box
                                              elevation: 2, // add shadow
                                              shape: RoundedRectangleBorder(
                                                  borderRadius: BorderRadius.circular(16)
                                              ),
                                              margin: EdgeInsets.only(bottom: 16), // space out
                                              child: ExpansionTile(
                                                  leading: Icon(Icons.event),
                                                  title: Text(
                                                    activity['name'] ?? 'Activity',
                                                    // optional add style
                                                  ), // add icon on left side
                                                  subtitle: activity['dateTime'] != null
                                                      ? Text(_formatDateTime(activity['dateTime'] as Timestamp))
                                                      : null,
                                                  children: [
                                                    Padding(
                                                        padding: EdgeInsets.all(16),
                                                        child: Column(
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Text("Description:"),
                                                            SizedBox(height: 8), // give some difference
                                                            Text(activity['description'] ?? 'No description provided'),
                                                          ],
                                                        )
                                                    )
                                                  ]
                                              )
                                          );
                                        }).toList(),
                                      ],
                                    );
                                  },

                                );
                              }
                          ) ;

                        }
                    ),
                  ],
                ),
              )
            ]
          )
        )
    );
  }
}

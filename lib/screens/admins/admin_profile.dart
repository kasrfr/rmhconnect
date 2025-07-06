import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/ProfilePhoto.dart';
import 'package:rmhconnect/screens/residents/org_get_info.dart';
import 'package:rmhconnect/screens/admins/memberlist.dart';


class AdminProfile extends StatefulWidget {
  const AdminProfile({super.key});

  @override
  State<AdminProfile> createState() => _AdminProfileState();
}

class _AdminProfileState extends State<AdminProfile> {
  User? user;
  late TextEditingController namecontrol = TextEditingController();
  late TextEditingController rolecontrol = TextEditingController();

  @override
  void initState(){
    super.initState();
    user = FirebaseAuth.instance.currentUser;
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
            ),
            ListTile(
              leading: Icon(Icons.delete, color: Colors.red),
              title: Text(
                'Delete Account',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () => Navigator.pop(context, 'delete'),
            ),
          ],
        ),
      ),
    );
    if (action == 'logout') {
      await FirebaseAuth.instance.signOut();
      if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
    } else if (action == 'delete') {
      await user?.delete();
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user!.uid)
          .delete();
      if (mounted) Navigator.pushReplacementNamed(context, '/welcome');
    }
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
                  IconButton(icon: Icon(Icons.settings), onPressed: _showSettingsMenu),
                ],
              ),
            ),
          ]
      ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: backgroundColor,
          onPressed: (){
            showDialog(
                context: context,
                builder: (BuildContext context){
                  return AlertDialog(
                      title: Text("Admin New Admin"),
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          TextField(
                            controller: namecontrol,
                            decoration: InputDecoration(
                              labelText: "New Admin Name",
                            ),
                          ),
                          SizedBox(height: 20),
                          TextField(
                            controller: namecontrol,
                            decoration: InputDecoration(
                              labelText: "New Admin Role",
                            ),
                          ),
                          SizedBox(height: 20),
                          Row(
                            children: [
                              OutlinedButton(
                                onPressed: () {
                                  Navigator.pop(context);
                                  namecontrol.clear();
                                  rolecontrol.clear();
                                },
                                child: Text("Cancel"),
                              ),
                              SizedBox(width: 20),
                              OutlinedButton(
                                onPressed: () {
                                  setState(() {
                                    nmname = namecontrol.text;
                                    nmrole = rolecontrol.text;
                                    namecontrol.clear();
                                    rolecontrol.clear();
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
      body: Column(
          children:[
            Container(
            //children: [
              child: Column(
              children: [
                SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Profilephoto(
                          pfp: "https://tinyurl.com/muj74rse",
                    ),
                    Column(
                      children: [
                        Text(username, style: titlingblck),
                        Text(role, style: mytextnormal),
                        Text(email, style: TextStyle(fontSize: 18, decoration: TextDecoration.underline)),
                        Text(location, style: mytextnormal),
                      ]
                    )
                  ]
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0,10,0,0),
                  child: Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(25,0,0,0),
                        child: Text("My Branches: ", style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
                      ),
                      Text("Branch A", style: TextStyle(fontSize: 18, color: Colors.blue)),
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25,8,0,0),
                      child: Text("Branch A Admin List", style: TextStyle(fontSize: 15, color: backgroundColor, fontWeight: FontWeight.bold)),
                    ),


                  ],
                ),
              ],
            ),
            //]
          ),
            memberlist(name: "Carter", role: "President", pfp: "https://tinyurl.com/muj74rse"),
        ]
      )
    );
  }
}

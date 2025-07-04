import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/ProfilePhoto.dart';
import 'package:rmhconnect/screens/residents/org_get_info.dart';

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
                    OrgGetInfo()
                  ],
                ),
              )
            ]
          )
        )
    );
  }
}

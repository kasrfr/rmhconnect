import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dropdown_search/dropdown_search.dart';
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
  bool locationPressed = false;
  List<String> orgNames = [];
  bool isLoading = true;

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
          loadOrgNames();
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

  Future<void> loadOrgNames() async {
    final snapshot =
    await FirebaseFirestore.instance.collection('organizations').get();
    final names = snapshot.docs
        .map((doc) => doc.data()['name'] as String?)
        .whereType<String>()
        .toList();

    setState(() {
      orgNames = names;
      isLoading = false;
      print("Loaded $orgNames successfully");
    });
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
                  //Navigator.pushNamed(context, '/directory');
                  setState((){locationPressed = true;});
                  print("Successfully changed locationPressed to $locationPressed. isLoading is currently $isLoading.");// change to drop-dwon
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: Expanded(child:Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Current Branch:", style: TextStyle(fontSize:22, color:Colors.black)),
                      SizedBox(width: 10),
                      // if(locationPressed && isLoading){ const CircularProgressIndicator()};
                      /*locationPressed && (isLoading == false) ?
                      Column(
                        children:[
                          Text(location, style: TextStyle(fontSize:22, color: Colors.blue), softWrap: true),
                        ]
                      ) :*/
                      Expanded(
                        // todo: needs to be fixed so that everything is not all pushed to the left
                          child:
                          Text(location, style: TextStyle(fontSize:22, color: Colors.blue))
                      ), // , fontWeight: FontWeight.bold)),
                    ],
                  )),
                ),
              ),
              locationPressed && (isLoading == false) ?
                DropdownSearch<String>(
                    items: (f, cs) => orgNames,
                    popupProps: PopupProps.menu(
                        fit: FlexFit.loose
                    ),
                    selectedItem: location,
                    // todo: need to actually change the registered location in Firebase
                    onChanged: (val) => setState(() => location = val!)
                    // todo: need to fix the below to replace ln 192
                  /*onChanged: (val) { WidgetsBinding.instance.addPostFrameCallback((_) {
                      setState(() {
                        location = val!;
                        //locationPressed = false;
                      });
                    });
                    },*/
                )
              : SizedBox(),
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

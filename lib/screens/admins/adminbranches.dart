import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';

class Adminbranches extends StatefulWidget {
  const Adminbranches({super.key});

  @override
  State<Adminbranches> createState() => _AdminbranchesState();
}

class _AdminbranchesState extends State<Adminbranches> {
  late TextEditingController namecontrol = TextEditingController();
  late TextEditingController loccontrol = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Branches", style: titling),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context){
              return AlertDialog(
                  title: Text("Create New Branch"),
                  content: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: namecontrol,
                        decoration: InputDecoration(
                          labelText: "New Branch Name",
                        ),
                      ),
                      SizedBox(height: 20),
                      TextField(
                        controller: loccontrol,
                        decoration: InputDecoration(
                          labelText: "New Branch Location",
                        ),
                      ),
                      SizedBox(height: 20),
                      Row(
                        children: [
                          OutlinedButton(
                          onPressed: () {
                            Navigator.pop(context);
                            namecontrol.clear();
                            loccontrol.clear();
                          },
                          child: Text("Cancel"),
                        ),
                          SizedBox(width: 20),
                          OutlinedButton(
                            onPressed: () {
                              setState(() {
                                nbname = namecontrol.text;
                                nbloc = loccontrol.text;
                                namecontrol.clear();
                                loccontrol.clear();
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
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18.0),
          child: StreamBuilder<QuerySnapshot>(
            stream: FirebaseFirestore.instance.collection('organizations').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                return const Center(child: Text("No organizations found."));
              }

              final orgDocs = snapshot.data!.docs;

              return ListView.builder(
                itemCount: orgDocs.length,
                itemBuilder: (context, index) {
                  final data = orgDocs[index].data() as Map<String, dynamic>;
                  final String nbname = data['name'] ?? 'Unknown Name';
                  final String nbloc = data['location'] ?? 'Unknown Location';

                  return GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        '/admin_branch_details',
                        arguments: {
                          'name': nbname,
                          'location': nbloc,
                        },
                      );
                    },
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                      color: const Color(0xFFFFDEDE),
                      child: ListTile(
                        leading: const Icon(Icons.home, color: Colors.red),
                        title: Text(nbname, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                        subtitle: Text(nbloc, style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
                      ),
                    ),
                  );
                },
              );
            },
          ),
        )
      )
    );
  }
}

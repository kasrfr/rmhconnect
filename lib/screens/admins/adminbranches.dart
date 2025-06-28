import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/screens/Profile.dart';

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
        child: GestureDetector(
          onTap: (){
            Navigator.pushNamed(context, '/branch details');
          },
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18.0),
            child: Card(//modi// fy to match figma
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Color(0xFFFFDEDE),
              child: ListTile(
                leading: Icon(Icons.home, color: Colors.red),
                title: Text(nbname, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                subtitle: Text(nbloc, style: TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              )
            ),
          ),
        ),
      )
    );
  }
}

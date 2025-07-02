import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/screens/admins/memberlist.dart';

class AdminMembers extends StatefulWidget {
  const AdminMembers({super.key});

  @override
  State<AdminMembers> createState() => _AdminMembersState();
}

class _AdminMembersState extends State<AdminMembers> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: backgroundColor,
        title: Text("Members", style: titling),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(50,20,50,0),
          child: ListView(
            shrinkWrap: true,
            children: [
              memberlist(pfp: "https://media.cnn.com/api/v1/images/stellar/prod/160107100400-monkey-selfie.jpg?q=w_2912,h_1638,x_0,y_0,c_fill"),

            ]
          ),
        )
      )
    );
  }
}

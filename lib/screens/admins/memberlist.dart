import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/constants.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';

class memberlist extends StatelessWidget {
  final String pfp;
  const memberlist({super.key , required this.pfp});

  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(25.0),
      ),
      color: const Color(0xFFFFDEDE),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            CircleAvatar(
              radius: 40,
              backgroundImage: NetworkImage(pfp),
            ),
            SizedBox(width: 15),
            Column(
              children: [
                Text("Name", style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Role", style: const TextStyle(fontSize: 18, fontStyle: FontStyle.italic)),
              ]
            )
          ]
        ),
      )
    );
  }
}

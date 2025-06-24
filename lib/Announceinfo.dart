import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/varries.dart';
import 'package:flutter/material.dart';
import 'package:rmhconnect/Events.dart';
import 'package:rmhconnect/constants.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/Profile.dart';

class Announceinfo extends StatelessWidget {
  final String pname;
  final String ppfp;
  final String pdate;
  final String ptime;
  final String ptext;
  final String branch;

  const Announceinfo({super.key, required this.pname, required this.ppfp, required this.pdate, required this.ptime, required this.ptext, required this.branch});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 5),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 25.0),
          child: GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (_) => AlertDialog(
                  title: Text("$pname - $branch"),
                  content: Text(ptext),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: Text("Close"),
                    )
                  ],
                ),
              );
            },
            child: Card(
              clipBehavior: Clip.antiAlias,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
              color: Color(0xFFFFDEDE),
              elevation: 8,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 5),
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(ppfp),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("$pname - $branch", style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                          Text(
                            ptext,
                            style: TextStyle(fontSize: 14),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                          ),
                          Text(
                            "$pdate    $ptime",
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

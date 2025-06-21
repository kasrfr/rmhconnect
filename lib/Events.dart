import 'package:flutter/material.dart';
import 'package:rmhconnect/varries.dart';

class Events extends StatelessWidget {
  final String evname;
  final String evdescrip;
  final String evtime;
  final String evdate;
  const Events({super.key, required this.evname, required this.evdescrip, required this.evtime, required this.evdate});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        children: [
          SizedBox(height:25),
          Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
            color: Color(0xFFFFDEDE),
            elevation: 8,
            child:ExpansionTile(
                leading: Icon(Icons.calendar_today_rounded),
                title: Text(evname),
                subtitle: Text(evdate + "    " + evtime),
                trailing: Icon(Icons.arrow_drop_down),
                children: [
                  ListTile(
                    title: Text('Description', textAlign: TextAlign.center, style: mytextred),
                    subtitle: Text(evdescrip),
                  )
                ]
            )
          ),
        ]
      )
    );
  }
}

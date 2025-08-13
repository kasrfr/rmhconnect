import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../theme.dart';

class Signuporg extends StatefulWidget {
  final String photor;
  final String namee;
  final String linfo;
  const Signuporg({super.key, required this.photor, required this.namee, required this.linfo});

  @override
  State<Signuporg> createState() => _SignuporgState();
}

class _SignuporgState extends State<Signuporg> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Tooltip(
            message: widget.namee,
            child: Text(
              widget.namee,
              style: titling,
              softWrap: true,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          centerTitle: true,
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(90),
            child: Container(
              color: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      "Follow the ${widget.namee} branch",
                      style: mytextmed,
                      softWrap: true,
                    ),
                  ),
                  SizedBox(width: 10),
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text(
                      "Join",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),

        body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
        child: ListView(
          children: [
            Column(
              children: [
                Card(
                  color: CharityConnectTheme.cardColor,
                  clipBehavior: Clip.antiAlias,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25.0),
                  ),
                  elevation: 10,
                  child: Container(
                    height: 300,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage(widget.photor),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Text(widget.linfo, style: mytextnormal),
                ),
                SizedBox(height: 20),

              ]
            )
          ],
        ),
      )
    );
  }
}

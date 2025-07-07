import 'package:flutter/material.dart';

class Profilephoto extends StatelessWidget {
  final String pfp;
  const Profilephoto({super.key, required this.pfp});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 50,
      // backgroundImage: NetworkImage(pfp),
      backgroundImage: AssetImage(pfp),
      backgroundColor: Colors.white,
    );
  }
}

import 'package:flutter/material.dart';

class Profilephoto extends StatelessWidget {
  final String pfp;
  const Profilephoto({super.key, required this.pfp});

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: 80,
      backgroundImage: NetworkImage(pfp),
    );
  }
}

import 'package:flutter/material.dart';

class Logo extends StatelessWidget {
  final double height;
  final double borderRadius;
  const Logo({super.key, required this.height, this.borderRadius = 80});

  @override
  Widget build(BuildContext context) {
    return
      Container(
        margin: const EdgeInsets.symmetric(vertical: 80, horizontal: 80),
        height: height, // =350
        padding: EdgeInsets.symmetric(vertical: 0, horizontal: 63),
        decoration: BoxDecoration(
          // color: Colors.green,
          border: Border.all(
              width: 2,
              color: Colors.black
          ),
          borderRadius: BorderRadius.circular(borderRadius),
          image: DecorationImage(
                image: AssetImage("assets/images/rmhc_logo.png"),

                fit: BoxFit.cover
          )
        ),
    );
  }
}

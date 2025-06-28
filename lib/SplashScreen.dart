import 'package:flutter/material.dart';
import 'package:rmhconnect/screens/logo.dart';
import 'package:rmhconnect/constants.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final TextStyle versionStyle = TextStyle(
    color: Colors.white.withOpacity(0.5),
    fontSize: 32
  );
  final TextStyle titleStyle = TextStyle(
      fontSize: 32
  );
  @override
  void initState(){
    super.initState();
    init();
  }

  Future<void>// may not be loaded yet but when it is this is the type that will be returned/dealing with something that hasn't been built yet
               init() async{
    await Future.delayed(const Duration(seconds: 5));
    Navigator.pushReplacementNamed(context, '/admin_branch');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      body:
        SafeArea(
          child: Center(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.center,
              children:[
                Padding(
                  padding: const EdgeInsets.only(top: 75),
                  child: Text(
                    "Ronald McDonald",
                        softWrap: true,
                        style: titleStyle
                  ),
                ),
                Text(
                    "House Charities",
                    softWrap: true,
                    style: titleStyle
                ),
                Logo(height: 350),
                Spacer(flex: 1),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 0),
                  child: Text(
                      "Version 1.0.0",
                      style: versionStyle
                  ),
                ),
              ]
            ),
          )
        )

    );
  }
}

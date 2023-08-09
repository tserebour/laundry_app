import 'package:flutter/material.dart';

import 'ongoing.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(milliseconds: 2000), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => const Ongoing(),
        ),
      );
    });
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            decoration: BoxDecoration(color: Colors.blueAccent.withOpacity(.8)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    CircleAvatar(
                      backgroundColor: Colors.white,
                      radius: 50.0,
                      // child: Icon(
                      //   Icons.local_grocery_store,
                      //   color: Colors.black,
                      //   size: 50.0,
                      // ),
                      backgroundImage: AssetImage('assets/images/clean.png'),
                    ),
                    Padding(padding: EdgeInsets.only(top: 15.0)),
                    Text(
                      "Super Laundry Mobile App",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 24.0,
                          color: Colors.white),
                    )
                  ],
                ),
              ),
              // Expanded(
              //   flex: 1,
              //   child: Column(
              //     mainAxisAlignment: MainAxisAlignment.center,
              //     children: const [
              //       CircularProgressIndicator.adaptive(
              //         backgroundColor: Colors.white,
              //         value: 3.0,
              //       ),
              //       Padding(padding: const EdgeInsets.only(top: 20.0))
              //     ],
              //   ),
              // )
            ],
          )
        ],
      ),
    );
  }
}

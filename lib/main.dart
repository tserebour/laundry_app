import 'package:flutter/material.dart';
import '/pages/splash.dart';
import 'pages/splash.dart';
import 'confirmation_page.dart';
import 'pages/ongoing.dart';
import 'pages/login.dart';
import 'pages/signup.dart';
import 'pages/home.dart';
import 'pages/washing.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Laundry APP',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      routes: {
        '/': (context) => const SplashScreen(),
        '/ongoing': (context) => const Ongoing(),
        '/loginpage': (context) => const Login(),
        '/signupage': (context) => const Signup(),
        '/home': (context) => const MainBoard(),
        '/washing': (context) => const Washing(),
        '/confirmation_page': (context) => const ConfirmPage(),
      },
    );
  }
}

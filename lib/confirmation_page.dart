import 'package:flutter/material.dart';
import 'thanku_page.dart';



class ConfirmPage extends StatelessWidget {
  const ConfirmPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Thanks',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.green),
      home: const ThankYouPage(title: 'Thank you Page'),
    );
  }
}

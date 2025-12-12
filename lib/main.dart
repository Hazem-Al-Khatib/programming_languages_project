// ignore_for_file: use_key_in_widget_constructors
import 'package:flutter/material.dart';
import 'package:pl_project/screens/welcome_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Rental App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.light(),
      darkTheme: ThemeData.dark(),
      home: WelcomeScreen(),
    );
  }
}

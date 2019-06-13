import 'package:flutter/material.dart';
import 'package:quizzer/screens/input_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'quizzer',
      home: InputScreen(),
    );
  }

}
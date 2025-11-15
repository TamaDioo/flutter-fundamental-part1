import 'package:flutter/material.dart';
import 'random_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BLoC Demo Dio',
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: const RandomScreen(),
    );
  }
}

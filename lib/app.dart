import 'package:f_tutorial/assets/theme/index.dart';
import 'package:f_tutorial/screens/home.dart';
import 'package:flutter/material.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Groceries',
      theme: dartTheme,
      home: const HomeScreen(),
    );
  }
}
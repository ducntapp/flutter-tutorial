import 'package:f_tutorial/assets/theme/index.dart';
import 'package:f_tutorial/screens/home.dart';
import 'package:f_tutorial/store/index.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (ctx)=> AppProvider())
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: true,
        title: 'Flutter Native',
        theme: nativeTheme,
        home: const HomeScreen(),
      ),
    );
  }
}
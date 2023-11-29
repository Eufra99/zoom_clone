import 'package:flutter/material.dart';
import 'package:zoom_clone/screens/login_screen.dart';
import 'package:zoom_clone/utils/colors.dart';

import 'screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Zoom Clone',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: backgroundColor
      ),
      routes: {
        'login': (context) => const LoginScreen(),
      '/home': (context) => const HomeScreen(),
      },
      home: const LoginScreen(),
    );
  }
}

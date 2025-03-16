import 'package:flutter/material.dart';
import './pages/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system, // Uses system setting for dark/light mode
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.light, // Light theme
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Poppins',
        brightness: Brightness.dark, // Dark theme
      ),
      home: HomePage(),
    );
  }
}

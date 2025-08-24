import 'package:api_practice_app/view/Login/login_screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'API PRACTICE',
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.cyanAccent,
        appBarTheme: AppBarTheme(
          backgroundColor: Colors.transparent,
        ),
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      debugShowCheckedModeBanner: false,
      home: LoginScreen(),
    );
  }
}


import 'package:api_practice_app/socket/socket_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

void main() async{

  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Colors.black,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
      systemNavigationBarColor: Colors.black,
      systemNavigationBarIconBrightness: Brightness.light,

  ));
  await GetStorage.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      theme: ThemeData(
        scaffoldBackgroundColor: Colors.transparent,
        appBarTheme: const AppBarTheme(
          toolbarHeight: 65,
          elevation: 0,
          centerTitle: true,
          backgroundColor: Colors.cyanAccent,
          iconTheme: IconThemeData(color: Colors.green),
        ),
      ),
      debugShowCheckedModeBanner: false,
      defaultTransition: Transition.fadeIn,
      transitionDuration: const Duration(milliseconds: 200),
      home: SocketScreen(),

    );
  }
}


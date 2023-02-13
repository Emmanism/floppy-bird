import 'package:floppy_bird/screens/splash_screen.dart';
import 'package:flutter/material.dart';


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Floppy bird',
      debugShowCheckedModeBanner: false,
      home: SplashScreen()
    );
  }
}

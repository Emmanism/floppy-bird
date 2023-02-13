import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:floppy_bird/screens/game_screen.dart';
import 'package:floppy_bird/screens/homescreen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
    String? documentId;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return AnimatedSplashScreen(
      splash:Center(
        child: Column(
          children: <Widget>[
                   Expanded(
                     child: Image.asset('lib/images/splash.png',
                             width:200,
                             height:200,
                             ),
                   ),
              Text('Floppy bird',
              style: TextStyle(
                fontSize:15,
                fontFamily:'oswald',
                color:Colors.red,
                fontWeight:FontWeight.bold
              ),)
          ]
          ),
      ),
      nextScreen:  HomeScreen(
        documentId: documentId ?? '',
      ),
      splashTransition:SplashTransition.sizeTransition,
      duration:4000,
      pageTransitionType:PageTransitionType.topToBottom,
      animationDuration:const Duration(seconds:2),
      );
  }
}
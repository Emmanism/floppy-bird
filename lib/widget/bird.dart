import 'package:flutter/material.dart';

class Bird extends StatelessWidget {
  const Bird({
    this.birdYaxis,
    required this.birdHeight,
    required this.birdWidth,
  });


  final birdYaxis;
  final double birdHeight; // out of 2 being the entire height if the screen 
  final double birdWidth; // normal double value for width


  @override
  Widget build(BuildContext context) {
    return Container(
       alignment: Alignment(0,birdYaxis),
      child: Image.asset('lib/images/bird.png',
         // height:MediaQuery.of(context).size.height * 3 / 4 * birdHeight / 2,
         //width: MediaQuery.of(context).size.width * birdWidth / 2,
         height: 60,
         width:60,
         
      ),
    );
  }
}

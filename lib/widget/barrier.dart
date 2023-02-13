import 'package:flutter/material.dart';

class Barrier extends StatelessWidget {
  final double size;

 /*  final barrierX;
  final barrierHeight;
  final barrierWidth;
  final bool isThisBottomBarrier; */

  const Barrier({
    required this.size,

    /* this.barrierHeight,
    this.barrierWidth,
    this.barrierX,
    required this.isThisBottomBarrier, */
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 90,
      height: size,
      decoration:  BoxDecoration(
        color:   const Color.fromARGB(255, 158, 13, 3),
        border: Border.all(
          width: 10,
          color:Colors.green,
        ),
        borderRadius: BorderRadius.circular(15),
      ),
      /*  alignment: Alignment((2 * barrierX + barrierWidth) / (2 - barrierWidth),isThisBottomBarrier ? 1 : -1),
      child:Container(
        color:const Color.fromARGB(255, 158, 13, 3),
        width:MediaQuery.of(context).size.width * barrierWidth / 2,
        height:MediaQuery.of(context).size.height * 3 / 4 * barrierHeight / 2, 
      ) */
    );
  }
}
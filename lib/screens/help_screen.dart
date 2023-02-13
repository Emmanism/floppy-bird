import 'package:floppy_bird/widget/search_button.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:floppy_bird/services/theme.dart';


class HelpScreen extends StatelessWidget {
  const HelpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: const Color.fromRGBO(41, 30, 83, 1),
      appBar:AppBar(
        backgroundColor: const Color.fromRGBO(111, 0, 244, 1),
        elevation:0,
        centerTitle:true,
        leadingWidth: 45,
          leading: Align(
            alignment: Alignment.centerRight,
            child: SearchButton(
              icon:CupertinoIcons.back,
              onTap: (){
                Navigator.pop(context);
              }
                )),
                title: const Text('Help guide',
                style:kText,
                ),
                ),
                body:Container(
                   margin: const EdgeInsets.all(28),
                   child:Center(
                    child:Padding(
                      padding:const EdgeInsets.only(top: 60),
                      child:Stack(
                         clipBehavior:Clip.none,
                        children:<Widget>[
                          Transform(
                              transform: Matrix4.skewY(-0.02),
                              child:Container(
                                height:160,
                                   decoration: const BoxDecoration(
                          gradient: LinearGradient(
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                              colors: [
                                Color.fromRGBO(209, 4, 43, 1),
                                Color.fromRGBO(214, 61, 99, 1),
                              ]),
                          borderRadius: BorderRadius.all(Radius.circular(25)),
                        ),
                              )
                          ),
                          Padding(
                            padding: const EdgeInsets.all(18.0),
                            child:Column(
                              children:const <Widget>[
                                Text('1. Tap the screen the make the bird jump vertically whenever the bird comes in contact with barrier in its direction to avoid being killed',
                                style:TextStyle(
                                   color:Colors.white,
                                   fontSize: 12,
                                   fontWeight: FontWeight.bold,
                                ),         
                                ),
                                  SizedBox(height:5.0),
                                 Text('2. The harder you tap the screen,the higher the bird jump with a stronger velocity',
                                style:TextStyle(
                                   color:Colors.white,
                                   fontSize: 12,
                                   fontWeight: FontWeight.bold,
                                ),         
                                ),
                                  SizedBox(height:5.0),
                                Text('3. Ensure you avoid being killed by barriers coming to your path',
                                style:TextStyle(
                                   color:Colors.white,
                                   fontSize: 12,
                                   fontWeight: FontWeight.bold,
                                ),         
                                )
                              ]
                            )
                          ),
                            const Positioned(
                      bottom: 90,
                      left: 140,
                      child: Image(
                        image: AssetImage('lib/images/highscore.png'),
                        height: 150,
                      ),
                    )
                        ]
                      )
                    )
                   
                   )
                )
      );
  }
}
import 'package:floppy_bird/screens/game_screen.dart';
import 'package:floppy_bird/screens/help_screen.dart';
import 'package:floppy_bird/services/datalist.dart';
import 'package:floppy_bird/services/theme.dart';
import 'package:floppy_bird/widget/highscore_home.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';

class HomeScreen extends StatefulWidget {
  final String documentId;

  const HomeScreen({
    required this.documentId,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String,dynamic>> itemList =  data;
  var listScrollController =  ScrollController();
  var scrollDirection = ScrollDirection.idle;

  @override
  void initState(){
    listScrollController.addListener(() {
     setState((){
      scrollDirection = listScrollController.position.userScrollDirection;
     });
    });
    super.initState();
  }

  bool _scrollNotification(ScrollNotification notification){
    if(notification is ScrollEndNotification){
      setState(() {
         scrollDirection = ScrollDirection.idle;
      });
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(41, 30, 83, 1),
      body: Container(
          margin: const EdgeInsets.all(28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: const <Widget>[
                  Text(
                    'Hi Friend',
                    style: kText,
                  ),
                  Icon(Icons.category, color: Colors.white, size: 30),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 60),
                child: Stack(
                  clipBehavior:Clip.none,
                  children: <Widget>[
                    Transform(
                      transform: Matrix4.skewY(-0.02),
                      child: Container(
                        height: 160,
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
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(18.0),
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            const Text(
                              'Floppy bird',
                              style: kText,
                            ),
                          const SizedBox(height:3.0),
                            Row(
                              children: [
                                const Text(
                                  'Get a new highscore ',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15,
                                      fontWeight: FontWeight.bold),
                                ),
                               // HighScoreHome(documentId: widget.documentId)
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top:25,
                                right: 15,
                                left:10,
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                CircularPercentIndicator(
                                radius:25,
                                lineWidth:6,
                                animation: true,
                                percent:0.2,
                                circularStrokeCap:CircularStrokeCap.round,
                                progressColor:Colors.black87,
                              ), 
                                  Transform(
                                    transform: Matrix4.skewY(-0.05),
                                    origin: const Offset(50, 50),
                                    child:  InkWell(
                                         onTap: () {
                                              Navigator.push(context, MaterialPageRoute(
                              builder: (builder) =>const GameScreen(
                              )));},                
                                      child: const Material(
                                        borderRadius:  BorderRadius.all(
                                            Radius.circular(10)
                                            ),
                                        color: Colors.white,
                                        child: Padding(
                                          padding:  EdgeInsets.only(
                                            top: 10,
                                            bottom: 10,
                                            left: 20,
                                            right: 20,
                                          ),
                                          child:  Text(
                                            'Play',
                                            style: TextStyle(
                                              color: Colors.red,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]),
                    ),
                    const Positioned(
                      bottom: 90,
                      left: 195,
                      child: Image(
                        image: AssetImage('lib/images/bird.png'),
                        height: 120,
                      ),
                    )
                  ],
                ),
              ),
             /*  
              Padding(
              padding: const EdgeInsets.only(top: 45),
              child:Container(
                  height: 270,
                  width: 170,//color
                  child: NotificationListener<ScrollNotification>(
              onNotification: _scrollNotification,
               child: ListView(
                 controller: listScrollController,
                 scrollDirection: Axis.horizontal,
                 children: itemList.map((item) {
                   return AnimatedContainer(
                    duration:const Duration(milliseconds: 100),
                    transform: Matrix4.rotationZ(
                      scrollDirection==ScrollDirection.forward
                      ? 0.07
                      : scrollDirection==ScrollDirection.reverse
                      ? -0.07
                      : 0
                    ),
                    height: 270,
                    width: 170,//color
                    margin: const  EdgeInsets.symmetric(
                      horizontal: 16.0,
                      vertical:16.0
                    ),
                    decoration:BoxDecoration(
                      color: Color(item["color"]),
                      borderRadius:BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color:Color(item["color"]).withOpacity(0.6),
                          offset: const Offset(-6,4),
                          blurRadius: 10,
                        )
                      ]
                    ),
                    child: Stack(
                      children:<Widget>[
                         Column(
                        children:<Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                               top: 100,
                               left: 12,
                            ),
                            child: Text(item["title"],
                            style: kText,
                            ),
                          ),
                          Positioned(
                            bottom:250,
                            left:60,
                            child: Image.asset(
                              item["image"],
                              height: 100,
                            ),
                          )              
                        ]
                      ),
                      ]
                    ),                      
                     );
                 }).toList(),
               ),
                  ),
                )
              ),  */
              Padding(
                padding:const EdgeInsets.only(
                  top:25
                ),
                child: Container(
                  decoration:const BoxDecoration(
                    color: Color.fromRGBO(111, 0, 244, 1),
                    borderRadius: BorderRadius.all(Radius.circular(30)),  
                  ),
                   child:Padding(
                    padding:const EdgeInsets.only(
                      top:8,
                      bottom:8,
                      left:18,
                      right:18
                    ),
                     child: const Text('Welcome',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color:Colors.white,
                        fontSize: 20,
                      )
                     ),
                   ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(
                    top:100,
                  ),
                  child: Row(
                    children:<Widget>[
                      InkWell(
                        splashColor: Colors.grey,
                          onTap: () {
                                              Navigator.push(context, MaterialPageRoute(
                              builder: (builder) =>const GameScreen(
                              )));},               
                        child: Stack(
                            clipBehavior:Clip.none,
                          children:[
                            Transform(
                              transform:Matrix4.skewY(-0.2),
                              child: Container(
                                height:270,
                                width:140,
                                decoration:const BoxDecoration(
                                  gradient:LinearGradient(
                                    begin:Alignment.topCenter,
                                    end:Alignment.bottomCenter,
                                    colors:[
                                       Color.fromRGBO(234, 70, 61, 1),
                                       Color.fromRGBO(238, 109, 43, 1),
                                    ]
                                  ),
                                       borderRadius: BorderRadius.all(Radius.circular(20)),  
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top:100,
                                left:10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:<Widget>[
                                 const Text('Play game',
                                  style:kText,
                                  ),
                                 const  SizedBox(height:20),
                                  Container(
                                    decoration:BoxDecoration(
                                      color:const Color.fromRGBO(245, 198, 146, 1).withOpacity(0.5),
                                      borderRadius:  const BorderRadius.all(Radius.circular(20)),  
                                    ),
                                    child: const Icon(
                                       Icons.play_arrow,
                                       size: 40,
                                       color:Colors.white60
                                    ),
                                  )
                                ]
                              ),
                            ),
                          const Positioned(
                              bottom: 170,
                              left: 10,
                              child:  Image(
                                image:AssetImage('lib/images/play.png'),
                                height: 160,
                              ),
                            )
                          ]
                        ),
                      ),
                     const  SizedBox(width:20),
                        InkWell(
                          splashColor: Colors.grey,
                           onTap: () {
                                              Navigator.push(context, MaterialPageRoute(
                              builder: (builder) =>const HelpScreen(
                              )));},                
                          child: Stack(
                            clipBehavior:Clip.none,
                          children:[
                            Transform(
                              transform:Matrix4.skewY(-0.2),
                              child: Container(
                                height:270,
                                width:140,
                                decoration:const BoxDecoration(
                                  gradient:LinearGradient(
                                    begin:Alignment.topCenter,
                                    end:Alignment.bottomCenter,
                                    colors:[
                                       Color.fromRGBO(209, 145, 44, 1),
                                       Color.fromRGBO(212, 155, 101, 1),
                                    ]
                                  ),
                                       borderRadius: BorderRadius.all(Radius.circular(20)),  
                                )
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                top:100,
                                left:10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children:<Widget>[
                                 const Text('Help',
                                  style:kText,
                                  ),
                                 const  SizedBox(height:20),
                                  Container(
                                    decoration:BoxDecoration(
                                      color:const Color.fromRGBO(245, 198, 146, 1).withOpacity(0.5),
                                      borderRadius:  const BorderRadius.all(Radius.circular(20)),  
                                    ),
                                    child: const Icon(
                                       Icons.directions_subway_filled,
                                       size: 40,
                                       color:Colors.white60
                                    ),
                                  )
                                ]
                              ),
                            ),
                          const Positioned(
                              bottom: 190,
                             // left: 5,
                              child:  Image(
                                image:AssetImage('lib/images/help.png'),
                                height: 160,
                              ),
                            )
                          ]
                                              ),
                        ),
                      
                    ]
                  ),
                ),
              )
            ],
          )),
    );
  }
}

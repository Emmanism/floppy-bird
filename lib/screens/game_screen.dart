import 'package:flame_audio/flame_audio.dart';
import 'package:floppy_bird/widget/barrier.dart';
import 'package:floppy_bird/widget/bird.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'dart:async';

class GameScreen extends StatefulWidget {
  const  GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  static double birdYaxis = 0;
  double initialHeight = birdYaxis;
  double time = 0;
  double height = 0;
  bool gameHasStarted = false;
  double velocity = 2.8;
  double gravity = -4.9;
  double birdWidth = 0.1; // out of 2 being the entire width of the screen 
  double birdHeight  = 0.1; // out if two being the entire height of the screen
  static double barrierXone = 1.1;
  double barrierXtwo = barrierXone + 1.5;
  int currentScore = 0;
  double sizedOne = 150;
  double sizedTwo = 200;
  double sizedThree = 250;
  double barrierYone = 1.1;
  double barrierYtwo = -1.1;
  final _nameController = TextEditingController();
  int _highScore =  0;

  List<double>  barrierDown = [0.6,0.7,0.8,0.9,1.0,1.1];
  List<double> barrierUp = [-0.6,-0.6,-0.7,-0.8,-0.9,-1.0,-1.1];

  List <String> highscore_DocIds = [];
  late final Future? letsGetDocIds;

  bool musicPlaying = false;
  
  // don't forget to add audio in your pubspec
  




 
  


  // barrier variables
  static List<double> barrierX = [2,2 + 1.5];
  static double barrierWidth = 0.5; // out of two(-1,0,1) 
  List<List<double>> barrierHeight = [
    // out of 2,where two is the entire height of the screen 
    // [topheight bottomheight]
    [0.6, 0.4],
    [0.4, 0.6]
  ]; 

  Future<void> loadHigh() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
   setState((){
     _highScore = prefs.getInt('HighScore') ?? 0;
   });
    
  }

    /*     if(currentScore > _highScore){
                            _highScore = currentScore;   
                 }
                 if(currentScore > _highScore){
      _highScore = currentScore;
      await prefs.setInt('HighScore', _highScore);
    }
     setState((){
     _highScore =_highScore;
   });  */

    
void setHigh(int pts) async {
 SharedPreferences prefs = await SharedPreferences.getInstance();
 prefs.setInt('high', pts);
 
 setState(() {
   _highScore = pts;
 });
}

@override
void initState() {
 loadHigh(); // ADD THIS
 super.initState();
}

void lost(){
  if (currentScore > _highScore) {
     setHigh(currentScore);
   }
}

/* 

  @override
  void initState(){
    letsGetDocIds = getDocIds();
    super.initState();
  }

  Future getDocIds() async {
    await FirebaseFirestore.instance
    .collection("highscores")
    .orderBy("score",descending:true)
    .limit(2)
    .get()
    .then((value) => value.docs.forEach((element) {
      highscore_DocIds.add(element.reference.id);
      }));
  }
   */

  


  void jump() {
    currentScore++;
     // play audio
        if(!musicPlaying){
           FlameAudio.bgm.play('jump.wav');
           musicPlaying = true;
        }      
    setState(() {
      time = 0;
      initialHeight = birdYaxis;
    });
  }

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(const Duration(milliseconds: 60), (timer) {
      // a real physical jump is the same an upside down parabola
      // so this is a single quadratic equation
      height = gravity * time * time +
          velocity * time; // velocity must be too strong (5)
      setState(() {
        birdYaxis = initialHeight - height;
      });

      setState(() {
        if(barrierXone < -2){
          barrierXone += 3.5;
        }
        else{
          barrierXone -= 0.05;
        }
      });
      setState(() {
        if(barrierXtwo < -2){
          barrierXtwo += 3.5;
        }
        else{
          barrierXtwo -= 0.05;
        }
      });
      if (birdYaxis < -1 || birdYaxis > 1) {
        timer.cancel();
        gameHasStarted = false;
      }

      if (birdIsDead()) {
        // play audio
        if(!musicPlaying){
           FlameAudio.bgm.play('lose.wav');
           musicPlaying = true;
        }      
        timer.cancel();
        _showDialog();
      }
      // keep the time going
      time += 0.05;
    });
  }

/* 
  acceleration y = -g
  velocity y = -gt + v
  height y = -gt^2 /2 + vt
  let g = 9.8  v = 5

 */

  bool birdIsDead() {
    if (birdYaxis < -1 || birdYaxis > 1) {
      return true;
    } 

   for(int i= 0; i < barrierDown.length; i++){
    if(birdYaxis >= barrierDown[i]){
      return true;
    }
   }
   for(int i= 0; i < barrierUp.length; i++){
    if(birdYaxis <=  barrierUp[i]){
      return true;
    }
   }
/* 
    for (int i = 0; i < barrierX.length; i++){
    if(barrierX[i] <= birdWidth && 
    barrierX[i] + barrierWidth >= -birdWidth &&
    (birdYaxis <= -1 + barrierHeight[i][0] ||
    birdYaxis +  birdHeight >= 1 - barrierHeight[i][1]
    )) {
      return true;
    }
    } */
      return false; 
    
  }

/* 
  void submitScore(){
    // get access to the collection
    var database = FirebaseFirestore.instance;

    // add data to firebase
    database.collection('highscore').add({
      "name":_nameController,
      "score":currentScore,
    });
  } */


  void _showDialog() {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          loadHigh();
          return  AlertDialog(
            backgroundColor: const Color.fromARGB(255, 158, 13, 3),
            title: const Center(
              child: Text('G A M E  O V E R',
                  style: TextStyle(
                    color: Colors.white,
                  )),
            ),
            content: Column(
              children: <Widget>[
              Text(
                    'Score: $currentScore', // + currentScore.toString(), 
                     style: const TextStyle(
                     color:Colors.white
                     ),
              ),
            /*    TextField(
                controller: _nameController,
                decoration: const InputDecoration(
                  hintText: 'Enter name'
                ),
              ),            */
              ],
            ),
            actions: <Widget>[ 
              MaterialButton(
                color:Colors.white,
                splashColor: Colors.orange,
                onPressed: (){
                  lost();
                 setState((){
                  gameHasStarted = false;
                 }); 
                  resetGame();
                },
                child: const Text('Play again',
                style: TextStyle(
                  color:  Color.fromARGB(255, 158, 13, 3),
                ),
                ),
              ),
             /*   GestureDetector(
                onTap: resetGame,
                child:  ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Container(
                    padding:const EdgeInsets.all(7),
                    color:Colors.white,
                    child:const Text(
                      'PLAY AGAIN',
                      style: TextStyle(
                        color: Color.fromARGB(255, 158, 13, 3),
                      ),
                    )


                  ),
                ),


              ),
 */
            ],
          );
        });
  }

  Future resetGame() async{
    // highscore_DocIds = [];
    // await getDocIds();
    Navigator.pop(context); // dismissing the alert dialog
    setState(() {
      birdYaxis = 0;
      gameHasStarted = false;
      time = 0;
      initialHeight = birdYaxis;
       barrierXone;
       barrierXtwo;
       currentScore = 0;
       musicPlaying = false;
    });
    
  }
  



  @override
  Widget build(BuildContext context) {
   // double screenWidth = MediaQuery.of(context).size.width;
   musicPlaying = false;
    return GestureDetector(
      onTap: () {
        if (gameHasStarted) {
              jump();
            } else {
              startGame();
          }
      },
      child: Scaffold(
        body: 
         // width: screenWidth > 500 ? 500 : screenWidth,
           Column(
            children: <Widget>[
              Expanded(
                  flex: 3,
                  child: Container(
                      // alignment: Alignment(0,birdYaxis), for animated container
                      // duration: const Duration(milliseconds: 0),
                      color: Colors.blue,
                      child: Center(
                        child: Stack(children: <Widget>[
                          Bird(
                            birdYaxis: birdYaxis,
                            birdHeight:birdHeight,
                            birdWidth: birdWidth,
                          ),
                          // bottom barrier 0
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 0),
                            alignment: Alignment(barrierXone, barrierYone),
                            child:  Barrier(
                              size: sizedTwo,
                            ),
                          ),
                          // top barrier 0
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 0),
                            alignment:  Alignment(barrierXone,barrierYtwo),
                            child:  Barrier(
                              size: sizedOne,
                            ),
                          ),
                          // bottom barrier 1
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 0),
                            alignment:Alignment(barrierXtwo,barrierYone),
                            child:  Barrier(
                              size: sizedOne,
                            ),
                          ),
                          // top barrier 1
                          AnimatedContainer(
                            duration: const Duration(milliseconds: 0),
                            alignment:Alignment(barrierXtwo, barrierYtwo),
                            child:  Barrier(
                              size: sizedThree,
                            ),
                          ),
            
                          // top barrier 0
                        /*   Barrier(
                            barrierX: barrierX[0],
                            barrierHeight: barrierHeight[0][0],
                            isThisBottomBarrier:false,
                            barrierWidth:barrierWidth,
                          ),
                          // bottom barrier 0
                          Barrier(
                            barrierX: barrierX[0],
                            barrierHeight: barrierHeight[0][1],
                            isThisBottomBarrier:true,
                            barrierWidth:barrierWidth,
                          ),
                          // top barrier 1
                          Barrier(
                            barrierX: barrierX[1],
                            barrierHeight: barrierHeight[1][0],
                            isThisBottomBarrier:false,
                            barrierWidth:barrierWidth,
                          ),
                          // bottom barrier 1
                          Barrier(
                            barrierX: barrierX[1],
                            barrierHeight: barrierHeight[1][1],
                            isThisBottomBarrier:true,
                            barrierWidth:barrierWidth,
                          ), */
                          Container(
                              alignment: const Alignment(0, -0.5),
                              child: Text(
                                  gameHasStarted ? '' : 'TAP TO PLAY',
                                  style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 23,
                                      letterSpacing: 3.0
                                      )))
                        ]),
                      ))),
                  Container(
                    color:Colors.green,
                    height:15
                  ),
              Expanded(
                  child: Container(
                      color: const Color.fromARGB(255, 158, 13, 3),
                      child: Row(
                        mainAxisAlignment:MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                        Column(
                           mainAxisAlignment:MainAxisAlignment.center,
                          children:  <Widget>[
                           const  Text('SCORE',
                            style:TextStyle(
                            color:Colors.white,
                            fontSize:15
                            )
                            ),
                            const SizedBox(height: 20),
                            Text(currentScore.toString(),
                            style:const TextStyle(
                            color:Color.fromRGBO(255, 255, 255, 1),
                            fontSize:35                        
                            ),
                            ),
                          ]),
                        Column(
                           mainAxisAlignment:MainAxisAlignment.center,
                          children:  <Widget>[
                            const Text('HighScore',
                            style:TextStyle(
                            color:Colors.white,
                            fontSize:15                        
                            )),
                           const  SizedBox(height: 20),
                           /*  Expanded(
                              child: gameHasStarted
                               ? Container() : FutureBuilder(
                              future: letsGetDocIds,
                              builder: (context,snapshot){
                                 return ListView.builder(
                                shrinkWrap:true,
                                 physics: const ScrollPhysics(), 
                                scrollDirection:Axis.vertical,
                                itemCount: highscore_DocIds.length,
                                itemBuilder: ((context, index) {
                                  return HighScoreTile(documentId:highscore_DocIds[index]);
                                })
                                ); 
                              }
                              ),
                            ), */
                            Text('$_highScore',
                            style:const TextStyle(
                            color:Color.fromRGBO(255, 255, 255, 1),
                            fontSize:35                        
                            ),
                            )
                          ])
                          ])))
            ],
          ),
      ),
    );
  }
}

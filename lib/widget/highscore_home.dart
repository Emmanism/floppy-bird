import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:floppy_bird/services/theme.dart';
import 'package:flutter/material.dart';


class HighScoreHome extends StatelessWidget {
   String? documentId;

    HighScoreHome({
     required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    // get the collection of highscores
    CollectionReference highscores = FirebaseFirestore.instance.collection("highscores");
    return FutureBuilder<DocumentSnapshot>(   
      future: highscores.doc(documentId ?? '1').get(),
      builder: (context, snapshot)  {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String , dynamic>;
           return  Text(data['score'].toString(),
           style: kText,
           );
        }else{
          return const Text('');
        }
      }
    );
  }
}
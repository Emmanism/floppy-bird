import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


class HighScoreTile extends StatelessWidget {
  final String documentId;

  const HighScoreTile({
    required this.documentId,
  });

  @override
  Widget build(BuildContext context) {
    // get the collection of highscores
    CollectionReference highscores = FirebaseFirestore.instance.collection("highscores");
    return FutureBuilder<DocumentSnapshot>(
      future: highscores.doc(documentId).get(),
      builder: (context, snapshot)  {
        if(snapshot.connectionState == ConnectionState.done){
          Map<String, dynamic> data = snapshot.data!.data() as Map<String , dynamic>;
           return Expanded(
             child: Row(
                    children: <Widget>[
           /*    Text( data['Name:']),
             const SizedBox(width: 10), */
             Text(data['score'].toString()),
                    ],
                  ),
           );
        }else{
          return const Text('loading....');
        }
       
      }
      );
  }
}
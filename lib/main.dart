import 'package:flame_audio/flame_audio.dart';
import 'package:flutter/material.dart';
import 'app.dart';
import 'package:firebase_core/firebase_core.dart';

 Future <void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
 // Flame.device.fullScreen();
  // initialize flame audio background music
  FlameAudio.bgm.initialize();
  if(Firebase.apps.isEmpty){
    await Firebase.initializeApp(
  name:'floppy-bird-86be9',
  options: const FirebaseOptions(
  apiKey: "AIzaSyCaD18ES3BHefsxFsWurBrgYaBj2rsGug0",
  authDomain: "floppy-bird-86be9.firebaseapp.com",
  projectId: "floppy-bird-86be9",
  storageBucket: "floppy-bird-86be9.appspot.com",
  messagingSenderId: "276873394940",
  appId: "1:276873394940:web:a14d74aa123604a0117579",
  measurementId: "G-EGS48L6TGT"
    )
  );
  }
  runApp(const MyApp());
}


import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:myrecipe/login/loginControl.dart';
import 'package:myrecipe/login/sharedPrefs.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await SharedPrefs.initialize();
  runApp(MyApp());
}

class MyApp extends StatelessWidget{
  @override
  Widget build (BuildContext context){
    //ekran dönümünü kitle
    SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LoginControl(),
    );
  }
}
 



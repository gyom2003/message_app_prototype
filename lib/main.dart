import 'package:firebase_project/wrapper.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project/Services/auth.dart';
import 'package:firebase_project/utilisateurfolder/user.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    //ecoute les donneés du stream user
    return StreamProvider<User>.value(
      
      //nouvelle val _auth 
      value: AuthServices().user,
      child: MaterialApp(
      title: 'Firebase Entrainement',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue, 
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: Wrapper(),
    ),
  );
}
}



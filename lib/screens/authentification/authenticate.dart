import 'package:flutter/material.dart';
import 'sign_in.dart';
import 'register.dart';
//import 'package:firebase_auth/firebase_auth.dart';

//authentification ui et firebase email password
class Authentification extends StatefulWidget {
  @override
  _AuthentificationState createState() => _AuthentificationState();
}

class _AuthentificationState extends State<Authentification> {
  //bool var true sign in : register page
  bool showSignin = true;
  //void qui régule la valeur bool
  void switchView() {
    //avec un setState
    setState(() => showSignin = !showSignin);
    //impicitement false pour permettre user de créer son compte

  }
  @override
  Widget build(BuildContext context) {
    if (showSignin) {
      //passer bool var en parametre des deux pages
      return SignIn(switchView: switchView);
    } else {
      return Register(switchView: switchView);
    }
  }
}
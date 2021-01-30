//import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/screens/authentification/authenticate.dart';
import 'package:firebase_project/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_project/utilisateurfolder/user.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //accède aux données de l'user en haut l'hiérarchide de l'app
    final user = Provider.of <User>(context);
    print(user);
    //renvoie home ou login page
    if (user == null) {
      return Authentification();
    } else {
      return HomePage();
    }
  }
}
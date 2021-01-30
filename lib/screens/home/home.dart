//homepage
import 'package:firebase_project/Services/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_project/Services/database.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomePage extends StatelessWidget {
   final AuthServices _auth = AuthServices();
  @override
  Widget build(BuildContext context) {
    return StreamProvider<QuerySnapshot>.value(
      value: CloudDatabase().streamcloud, 
          child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(title: Text("Home Appbar"),
        backgroundColor: Colors.grey[500],
        elevation: 5,
        centerTitle: true,
        titleSpacing: 12,
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () => {}),
        actions:<Widget>[
          FlatButton.icon(icon: Icon(Icons.person), label: Text("se déconnecté"),
          onPressed: () async {
            await _auth.signOut();
          },)
        ],
        ),
        body: Applist(), 
      ),
    );
  }
}

class Applist extends StatefulWidget {
  @override
  _ApplistState createState() => _ApplistState();
}

class _ApplistState extends State<Applist> {
  @override
  Widget build(BuildContext context) {
    final collectdata = Provider.of<QuerySnapshot>(context);
    //les afficher un par un 
    for (var i in collectdata.documents) {
      print(i.data);
    }
    return Container(
    );
  }
}
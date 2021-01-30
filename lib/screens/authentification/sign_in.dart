
import 'package:flutter/material.dart';
import 'package:firebase_project/Services/auth.dart';
import 'package:firebase_project/fichier partagées/loading.dart';

//import 'package:firebase_auth/firebase_auth.dart';
//page sign in regularié par wrap

class SignIn extends StatefulWidget {
   final Function switchView;
  SignIn({this.switchView});
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final AuthServices _auth = AuthServices();
  final _formkey = GlobalKey<FormState>();
  bool shouldloading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    //pour afficher loading effect en fonction val bool 
    return shouldloading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline), 
        onPressed: () async {
          if (_formkey.currentState.validate()) {
            setState(() => shouldloading = true);
            dynamic result = await _auth.signinWithEmailAndPassword(email, password);
            if (result == null) {
              setState(() {
                error = 'erreur de connexion';
                shouldloading = false;
                });
            } else {
              setState(() => error = 'le connexion fonctionne avec succès !');
            }
          }
          print(email);
          print(password);
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[500], 
        child: Container(height: 30.0), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text("Sign in app bar"), 
        elevation: 15,
        centerTitle: true,
        titleSpacing: 12,
        //leading icon
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () => {}), 
        actions:<Widget> [
          //ajouter boutton aller retour sign in register page
          FlatButton.icon(icon: Icon(Icons.person), label: Text("s'enregistrer ?"), 
          onPressed: () => {
            widget.switchView()})
        ], 
      ),
      //definition body sign in page
      body: Container(
        padding: EdgeInsets.symmetric(horizontal:20.0, vertical:50.0),
        child: Form(
          key: _formkey,
          //ranger formfield
          child: Column(
            children: <Widget>[
              SizedBox(height: 40, width: 10), 
              TextFormField(
                validator: (str) => !str.contains('@') ? "email non valable" : null,
                //fonction qui s'execute chaque fois que val forfield change
                onChanged: (value) {
                  //charger value dans email et password
                  setState(() => email = value);
                },
                cursorColor: Colors.greenAccent,
                decoration: InputDecoration(
                  fillColor: Colors.grey[300],
                  filled: true,
                  hintText: 'Email',
                  enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.transparent),
                    borderRadius: BorderRadius.all(Radius.circular(10))
                    ),
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.greenAccent),
                    borderRadius: BorderRadius.all(Radius.circular(35)),
                    ),
                  labelText: "Email: "
                ),
              ),
              SizedBox(height: 40, width: 10),
              TextFormField(
                validator: (str) => str.length <= 5 ? "mot de passe non valide": null,
                obscureText: true,
                //fonction qui s'execute chaque fois que val forfield change
                onChanged: (value) {
                  //charger value dans email et password
                  setState(() => password = value);
                },
                cursorColor: Colors.greenAccent,
              decoration: InputDecoration(
                hintText: 'Mot de passe',
                fillColor: Colors.grey[300],
                filled: true,
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.transparent),
                  borderRadius: BorderRadius.all(Radius.circular(10))
                  ),
                  focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.greenAccent),
                  borderRadius: BorderRadius.all(Radius.circular(35)),
                  ),
                labelText: "Mot de passe: "
              ),
              ),
              SizedBox(height: 12.0),
              Text(
                error, 
                style: TextStyle(color: Colors.grey[800], fontWeight: FontWeight.bold),
              ),
              //SizedBox(height: 300),    
            ],
          ),
        ), 
      ),
    );
  }
}
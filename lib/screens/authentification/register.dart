
import 'package:flutter/material.dart';
import 'package:firebase_project/Services/auth.dart';
import 'package:firebase_project/fichier partagées/loading.dart'; 
class Register extends StatefulWidget {
  final Function switchView;
  Register({this.switchView});
  @override
  //instancier la fonction switchView pour l'accepter en param des pages
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
    //var finale
  final _formkey = GlobalKey<FormState>();
  final AuthServices _auth = AuthServices();
  bool shouldloading = false;
  //text field state
  String email = '';
  String password = '';
  String error = '';

  @override

  Widget build(BuildContext context) {
    return shouldloading ? Loading() : Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add_circle_outline), 
        onPressed: () async {
          //verification validation TextFormField 
          if (_formkey.currentState.validate()) {
            setState(() => shouldloading = true);
            dynamic result = await _auth.registerWithEmailAndPassword(email, password);
            if (result == null) {
              setState(() {
                error = 'erreur de création de compte ça arrive aux meilleurs';
                shouldloading = false;
              });
            } else {
              setState(() => error = 'votre compte a été créer avec succès! ');
            }
            //vérification result
            print(email);
            print(password);
          } else {
            print("erreur validation register");
          }
        },
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.grey[500], 
        child: Container(height: 30.0), 
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        backgroundColor: Colors.grey[500],
        title: Text("register app bar"), 
        elevation: 15,
        centerTitle: true,
        titleSpacing: 12,
        //leading icon
        leading: IconButton(icon: Icon(Icons.menu), onPressed: () => {}),
        actions:<Widget> [
        //ajouter boutton aller retour sign in register page
        FlatButton.icon(icon: Icon(Icons.person), label: Text("se connecter ?"), 
        onPressed: () => {widget.switchView()},)
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
                autocorrect: false,
                //fonction qui s'execute chaque fois que val forfield change
                onChanged: (value) {
                  //pour pouvoir manipuler les val email et pssword
                  setState(() => email = value);
                  print(value);
                },
                validator: (str) => !str.contains('@') ? "email non valable" : null,
                cursorColor: Colors.greenAccent,
                decoration: InputDecoration(
                  hintText: 'Email',
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
                  labelText: "Email: "
                ),
              ),
              SizedBox(height: 40, width: 10),
              TextFormField(
                autocorrect: false,
                obscureText: true,
                //fonction qui s'execute chaque fois que val forfield change
                validator: (str) => str.length <= 5 ? "mot de passe non valide": null,
                onChanged: (value) {
                  //charger value dans email et password
                  setState(() => password = value);
                  print(value);
                },
                cursorColor: Colors.greenAccent,
              decoration: InputDecoration(
                fillColor: Colors.grey[300],
                filled: true,
                hintText: 'Mot de passe',
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
            ],
          ),
        ), 
      ),
    );
  }
}
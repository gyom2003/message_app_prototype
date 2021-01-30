
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_project/utilisateurfolder/user.dart';
import 'database.dart';
//classe qui gère l'authentification user (compte anonyme sign in sign out email, password compte...)
class AuthServices {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  //créer objet basé sur user et retourne ses pro (classe user)
  User _userFromFirebase(FirebaseUser user) {
    return user != null ? User(uid: user.uid) : null;
  }
  //stream définit si l'user est co ou pas et renvoyer quoi 
  Stream<User> get user {
    //régule le provider permet plusieurs authentifications 
    return _auth.onAuthStateChanged.map(_userFromFirebase);
    //map((FirebaseUser user) => _userFromFirebase(user))
  }
  //signer annymemement
  Future signInAnon() async {
    try {
      //ce résultat s'effectue on_pressed appbar button
      AuthResult result = await _auth.signInAnonymously();
      FirebaseUser user = result.user;
      //gerer les infos du user
      await CloudDatabase(uid: user.uid).updateUserData('guillaume', 17, 0);
      return _userFromFirebase(user);
    } catch(e) {
      //afficher l'erreur et ne rien retourner (pour ne pas faire beuger app)
      print(e.toString());
      return null;
    }
  }
  //enregistrer email password
  Future registerWithEmailAndPassword(String email, String password) async {
  try {
    //comme signement anon créer un resultat qu'on attend avec _auth
    AuthResult result = await _auth.createUserWithEmailAndPassword(email: email, password: password);
    //signInWithEmailAndPassword
    FirebaseUser user = result.user;
    print(user);
    //retourner son document avec son iud

    return _userFromFirebase(user);
    //fonction pour retourner l'iud de l'user
  } catch(e) {
    print(e.toString());
    return null;
  }
  }

  //sign in avec email password (signInWithEmailAndPassword)
  Future signinWithEmailAndPassword(String email, String password) async {
    try {
      AuthResult result = await _auth.signInWithEmailAndPassword(email: email, password: password);
      FirebaseUser user = result.user;
      print(user);
      return _userFromFirebase(user);
      //fonction pour retourner l'iud de l'user
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
  //se deconnecter
  Future signOut() async {
    try {
      return await _auth.signOut();
      //methide signOut();
    } catch(e) {
      print(e.toString());
      return null;
    }
  }
}
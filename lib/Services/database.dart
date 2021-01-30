import 'package:cloud_firestore/cloud_firestore.dart';
//import 'package:flutter/rendering.dart';


//document ranger dans des collections
class CloudDatabase {
  //retourner l'uid user dans le constructeur de cette classe chaque user aura son clouddatabase avec son uid
  final String uid;
  CloudDatabase({this.uid});
  //collection reference
  final CollectionReference reference = Firestore.instance.collection('reference');
  //ajouter document à cette collection
  Future updateUserData(String nom, int age, int book) async {
    //création de doc et ajout de data dans collection reference
    return await reference.document(uid).setData({
      'nom': nom, 
      'age': age,
      'book': book,
    });
  }
  //QuerySnapshot pour mieux acceder doc dans coll User reference (streamProvider.value)
  Stream<QuerySnapshot> get streamcloud {
    return reference.snapshots();
  } 
}
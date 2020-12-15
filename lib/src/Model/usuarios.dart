import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Usuarios {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn();

  //Constructor

  void ingresarAdmin(String nombre, String mail, String tipo) async {
    await FirebaseFirestore.instance.collection("usuarios").add({
      "nombre": nombre,
      "mail": mail,
      "tipo": tipo,
    }).then((value) => print(value.id));
  }

  void modificarAdmin(
      String id, String nombre, String mail, String tipo) async {
    await FirebaseFirestore.instance.collection("usuarios").doc(id).update({
      "nombre": nombre,
      "mail": mail,
      "tipo": tipo,
    }).then((_) {
      print("success!");
    });
  }

  void ingresarUsuario(String nombre, String mail, String tipo, String edad,
      String sexo, String peso, String altura) async {
    await FirebaseFirestore.instance.collection("usuarios").add({
      "nombre": nombre,
      "mail": mail,
      "tipo": "Cliente",
      "edad": edad,
      "sexo": sexo,
      "peso": peso,
      "altura": altura,
    }).then((value) => print(value.id));
  }

  void modificarUsuario(String id, String nombre, String mail, String tipo,
      String edad, String sexo, String peso, String altura) async {
    await FirebaseFirestore.instance.collection("usuarios").doc(id).update({
      "nombre": nombre,
      "mail": mail,
      "tipo": "Cliente",
      "edad": edad,
      "sexo": sexo,
      "peso": peso,
      "altura": altura,
    }).then((_) {
      print("success!");
    });
  }

  void eliminar(String id) async {
    await FirebaseFirestore.instance
        .collection("usuarios")
        .doc(id)
        .delete()
        .then((_) {
      print("success!");
    });
  }
}

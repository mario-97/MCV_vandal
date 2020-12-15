import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Ejercicio {
  //funciones
  void registrar(String actividad, String duracion, String kcalUsada,
      String tipo, String repeticiones, String imagen) async {
    await FirebaseFirestore.instance.collection("rutina").add({
      "actividad": actividad,
      "duracion": duracion,
      "kcalUsada": kcalUsada,
      "tipo": tipo,
      "repeticiones": repeticiones,
      "imagen": imagen,
    }).then((value) => print(value.id));
  }

  void actualizar(String id, String actividad, String duracion,
      String kcalUsada, String tipo, String repeticiones, String imagen) async {
    await FirebaseFirestore.instance.collection("rutina").doc(id).update({
      "actividad": actividad,
      "duracion": duracion,
      "kcalUsada": kcalUsada,
      "tipo": tipo,
      "repeticiones": repeticiones,
      "imagen": imagen,
    }).then((_) {
      print("success!");
    });
  }

  void eliminar(String id) async {
    await FirebaseFirestore.instance
        .collection("rutina")
        .doc(id)
        .delete()
        .then((_) {
      print("success!");
    });
  }
}

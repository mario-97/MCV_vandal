import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Dietas {
  void ingresar(String idCliente, String tipodieta, String rangoedad, String desayuno,
      String almuerzo, String cena, String merienda, String calorias, String dia) async {
    await FirebaseFirestore.instance.collection("dietasCliente").add({
      "idCliente": idCliente,
      "tipodieta": tipodieta,
      "rangoedad": rangoedad,
      "desayuno": desayuno,
      "almuerzo": almuerzo,
      "cena": cena,
      "merienda": merienda,
      "calorias": calorias,
      "dia": dia,
    }).then((value) => print(value.id));
  }

  void actualizar(
      String id,
      String dia) async {
    await FirebaseFirestore.instance.collection("dietasCliente").doc(id).update({
      "dia": dia,
    }).then((_) {
      print("success!");
    });
  }

  void eliminar(String id) async {
    await FirebaseFirestore.instance
        .collection("dietasCliente")
        .doc(id)
        .delete()
        .then((_) {
      print("success!");
    });
  }
}

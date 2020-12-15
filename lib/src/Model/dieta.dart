import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class Dietas {
  void ingresar(String tipodieta, String rangoedad, String desayuno,
      String almuerzo, String cena, String merienda, String calorias) async {
    await FirebaseFirestore.instance.collection("dietas").add({
      "tipodieta": tipodieta,
      "rangoedad": rangoedad,
      "desayuno": desayuno,
      "almuerzo": almuerzo,
      "cena": cena,
      "merienda": merienda,
      "calorias": calorias,
    }).then((value) => print(value.id));
  }

  void actualizar(
      String id,
      String tipodieta,
      String rangoedad,
      String desayuno,
      String almuerzo,
      String cena,
      String merienda,
      String calorias) async {
    await FirebaseFirestore.instance.collection("dietas").doc(id).update({
      "tipodieta": tipodieta,
      "rangoedad": rangoedad,
      "desayuno": desayuno,
      "almuerzo": almuerzo,
      "cena": cena,
      "merienda": merienda,
      "calorias": calorias,
    }).then((_) {
      print("success!");
    });
  }

  void eliminar(String id) async {
    await FirebaseFirestore.instance
        .collection("dietas")
        .doc(id)
        .delete()
        .then((_) {
      print("success!");
    });
  }
}

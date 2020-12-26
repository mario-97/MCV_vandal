import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/authscreen.dart';

class UserController extends StatelessWidget {
  final InfoEjercicio datos;
  UserController({this.datos});
  String idEjercicio;
  String idCliente = id;
  bool existe = false;
  @override
  Widget build(BuildContext context) {
    void agregar(
      String id_ejercicio,
      String nombre,
      String kcal,
      String tiempo,
    ) async {
      await FirebaseFirestore.instance.collection("ListaEjercicio").add({
        "id_ejercicio": datos.idEjercicio,
        "nombre": datos.nombre,
        "Kcal": datos.kcal,
        "tiempo": datos.tiempo,
        "id_cliente": datos.idCliente,
        "estado": "Asignado",
      }).then((value) => print(value.id));

      await FirebaseFirestore.instance
          .collection("rutina")
          .doc(datos.idEjercicio)
          .update({
        "estado": "Seleccionado",
      }).then((_) {
        print("success!");
      });
    }

    void eliminar() async {
      await FirebaseFirestore.instance
          .collection("ListaEjercicio")
          .doc(this.datos.idInfo)
          .delete()
          .then((_) {
        print("success!" +
            this.datos.idInfo +
            "vacio?" +
            datos.idEjercicio +
            "," +
            datos.idCliente);
      });
      await FirebaseFirestore.instance
          .collection("rutina")
          .doc(datos.idEjercicio)
          .update({
        "estado": "No seleccionado",
      }).then((_) {
        print("success!" +
            this.datos.idInfo +
            "vacio?" +
            datos.idEjercicio +
            "," +
            datos.idCliente);
      });

      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Selecc()));
    }

    void marcar() async {
      await FirebaseFirestore.instance
          .collection("ListaEjercicio")
          .doc(datos.idInfo)
          .update({
        "estado": "Realizado",
      }).then((_) {
        print("success!" + this.datos.idInfo);
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Selecc()));
    }

    void resumen() async {
      Query query = FirebaseFirestore.instance.collection("ListaEjercicio");
      Query query2 = FirebaseFirestore.instance.collection("Resumen");

      int count = 0;
      await query2.get().then((querySnapshot) async {
        count = querySnapshot.size;
      });
      await FirebaseFirestore.instance.collection("Resumen").add({
        "totalkcal": datos.totalkcal,
        "totaltiempo": datos.totaltiempo,
        "id_cliente": datos.idCliente,
        "id_incremental": count,
      }).then((value) => print(value.id));
      WriteBatch batch = FirebaseFirestore.instance.batch();
      await query.get().then((querySnapshot) async {
        querySnapshot.docs.forEach((document) {
          batch.update(document.reference, {'estado': "Asignado"});
        });
        await batch.commit();
      });

      Navigator.of(context).pop();
    }

    void metas() async {
      Query query = FirebaseFirestore.instance.collection("Estadistica");
      WriteBatch batch = FirebaseFirestore.instance.batch();
      await query.get().then((querySnapshot) async {
        querySnapshot.docs.forEach((document) {
          batch.update(document.reference, {
            'kgobjetivo': this.datos.kgobjetivo,
            'tiempoobjetivo': this.datos.tiempoobjetivo
          });
        });
        await batch.commit();
      });

      Navigator.pop(context);
    }

    if (datos.operacion == "Ingresar") {
      agregar(datos.idEjercicio, datos.nombre, datos.kcal, datos.tiempo);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Selecc()));
    } else if (datos.operacion == "Eliminar") {
      eliminar();
    } else if (datos.operacion == "Marcar") {
      marcar();
    } else if (datos.operacion == "Terminar") {
      resumen();
      Navigator.of(context).pop();
    } else if (datos.operacion == "Metas") {
      metas();
    }
    return Container(child: Text(datos.operacion));
  }
}

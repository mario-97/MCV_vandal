import 'package:mvp_vandal/src/model/ejercicio.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/entrenador/listejercicios.dart';

class ControllerEjercicio extends StatelessWidget {
  final Actividad datos;
  ControllerEjercicio({this.datos});

  @override
  Widget build(BuildContext context) {
    void addEjercicio() {
      Ejercicio().registrar(datos.actividad, datos.duracion, datos.kcalUsada,
          datos.tipo, datos.repeticiones, datos.imagen);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Ejercicios()));
    }

    void updateEjercicio() {
      Ejercicio().actualizar(datos.id, datos.actividad, datos.duracion,
          datos.kcalUsada, datos.tipo, datos.repeticiones, datos.imagen);
      Navigator.pop(context);
    }

    void deleteEjercicio() {
      Ejercicio().eliminar(datos.id);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Ejercicios()));
    }

    if (datos.operacion == "Registrar") {
      addEjercicio();
    }
    if (datos.operacion == "Actualizar") {
      updateEjercicio();
    }
    if (datos.operacion == "Eliminar") {
      deleteEjercicio();
    }

    return Container(
      child: Text("Nombre: " + datos.actividad),
    );
  }
}

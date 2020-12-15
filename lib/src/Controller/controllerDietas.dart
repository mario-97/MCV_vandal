import 'package:mvp_vandal/src/model/dieta.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/nutricionista/dietas.dart';

class ControllerDietas extends StatelessWidget {
  final Minuta datos;
  ControllerDietas({this.datos});

  @override
  Widget build(BuildContext context) {
    void addDieta() {
      Dietas().ingresar(datos.tipodieta, datos.rangoedad, datos.desayuno,
          datos.almuerzo, datos.cena, datos.merienda, datos.calorias);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dieta()));
    }

    void deleteDieta() {
      Dietas().eliminar(datos.id);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Dieta()));
    }

    void updateDieta() {
      Dietas().actualizar(
          datos.id,
          datos.tipodieta,
          datos.rangoedad,
          datos.desayuno,
          datos.almuerzo,
          datos.cena,
          datos.merienda,
          datos.calorias);
      Navigator.pop(context);
    }

    if (datos.operacion == "Ingresar") {
      addDieta();
    }
    if (datos.operacion == "Eliminar") {
      deleteDieta();
    }
    if (datos.operacion == "Actualizar") {
      updateDieta();
    }
    return Container(
      child: Text("Nombre: " + datos.id),
    );
  }
}

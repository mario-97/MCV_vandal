import 'package:flutter/cupertino.dart';
import 'package:mvp_vandal/src/model/dietaCliente.dart';
import 'package:mvp_vandal/src/datos/minutaCliente.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/DietasHome.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/ErrorDia.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ControllerDietasCliente extends StatelessWidget {
  final MinutaCliente datos;
  ControllerDietasCliente({this.datos});

  @override
  Widget build(BuildContext context) {


  Query query = FirebaseFirestore.instance.collection("dietasCliente");
  

    void addDieta() {
      Dietas().ingresar(datos.idCliente, datos.tipodieta, datos.rangoedad, datos.desayuno,
          datos.almuerzo, datos.cena, datos.merienda, datos.calorias, datos.dia);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DietasHomeCliente()));
    }

    void deleteDieta() {
      Dietas().eliminar(datos.id);
      Navigator.push(context, MaterialPageRoute(builder: (context) => DietasHomeCliente()));
    }

    void updateDieta() {
      Dietas().actualizar(
          datos.id,
          datos.dia);
      Navigator.pop(context);
    }

    

    if (datos.operacion == "Ingresar") {

      if (datos.dia == "1" || datos.dia == "2" || datos.dia == "3" || 
          datos.dia == "4" || datos.dia == "5" || datos.dia == "6" || datos.dia == "7" ) {
          addDieta(); 
      }
      else { 
      Navigator.push(context, MaterialPageRoute(builder: (context) => ErrorDia()));
      }
    }
            

              
    
    
    if (datos.operacion == "Eliminar") {
      deleteDieta();
    }
    if (datos.operacion == "Actualizar") {
      updateDieta();
    }
    return Container(
      child: Text("Nombre: " + datos.idCliente),
      
    );
  }
}


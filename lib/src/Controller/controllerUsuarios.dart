import 'package:mvp_vandal/src/model/usuarios.dart';
import 'package:mvp_vandal/src/datos/user.dart';
import 'package:mvp_vandal/src/miapp.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/admin/listauser.dart';

class ControllerUsuarios extends StatelessWidget {
  final Users datos;
  ControllerUsuarios({this.datos});

  @override
  Widget build(BuildContext context) {
    void controllerAdd() {
      Usuarios().ingresarUsuario(datos.nombre, datos.mail, datos.tipo,
          datos.edad, datos.sexo, datos.peso, datos.altura);
      Navigator.pop(
        context,
      );
    }

    void controllerUpd() {
      Usuarios().modificarUsuario(datos.id, datos.nombre, datos.mail,
          datos.tipo, datos.edad, datos.sexo, datos.peso, datos.altura);
      Navigator.pop(
        context,
      );
    }

    void controllerAddAdmin() {
      Usuarios().ingresarAdmin(datos.nombre, datos.mail, datos.tipo);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Lista()));
    }

    void controllerUpdAdmin() {
      Usuarios().modificarAdmin(datos.id, datos.nombre, datos.mail, datos.tipo);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Lista()));
    }

    void controllerEliminarAdmin() {
      Usuarios().eliminar(datos.id);
      Navigator.push(context, MaterialPageRoute(builder: (context) => Lista()));
    }

    if (datos.operacion == "Ingresar") {
      controllerAdd();
    }
    if (datos.operacion == "Modificar") {
      controllerUpd();
    }
    if (datos.operacion == "IngresarAdmin") {
      controllerAddAdmin();
    }
    if (datos.operacion == "ModificarAdmin") {
      controllerUpdAdmin();
    }
    if (datos.operacion == "EliminarAdmin") {
      controllerEliminarAdmin();
    }
    return Container(
      child: Text("Nombre: " + datos.id),
    );
  }
}

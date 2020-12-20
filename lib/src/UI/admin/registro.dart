import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/admin/listauser.dart';
import 'package:mvp_vandal/src/datos/user.dart';
import 'package:mvp_vandal/src/Controller/controllerUsuarios.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class RegistroAdmin extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      home: Registro(),
    );
  }
}

class Registro extends StatefulWidget {
  @override
  _RegistroState createState() => _RegistroState();
}

class _RegistroState extends State<Registro> {
  final Users datos = new Users("", "", "", "", "", "", "", "", "");
  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();
  final TextEditingController contcmp6 = new TextEditingController();
  final TextEditingController contcmp7 = new TextEditingController();
  final TextEditingController contcmp8 = new TextEditingController();
  final TextEditingController contcmp9 = new TextEditingController();

  var Docs;
  int _value = 1;
  var categoria = [
    "Administrador",
    "Nutricionista",
    "Kinesiologo",
    "Entrenador",
  ];
  bool existe = false;
  String id;
  String nombre = "Nombre de usuario";
  String mail = "Correo Electronico";
  String tipo = "Tipo de usuario";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      initialRoute: '/registro',
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: GradientAppBar(
          title: Text('Usuario del Sistema'),
          backgroundColorStart: Colors.orange[900],
          backgroundColorEnd: Colors.amber,
        ),
        body: Center(
          child: Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: [
                  0.1,
                  0.4,
                  0.6,
                  0.9
                ],
                    colors: [
                  Colors.amber[100],
                  Colors.amber[500],
                  Colors.amber[700],
                  Colors.amber[900]
                ])),
            margin: new EdgeInsets.symmetric(horizontal: 0.0),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                    Widget>[
              Container(
                  margin: new EdgeInsets.symmetric(horizontal: 30.0),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: <Widget>[
                        new Image(
                            image: new AssetImage('assets/images/2.png'),
                            height: 120,
                            alignment: Alignment.center),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: new TextField(
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                  decoration: new InputDecoration(
                                      contentPadding: const EdgeInsets.all(20),
                                      fillColor: Colors.white,
                                      hintText: nombre,
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                  controller: contcmp3,
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: new TextField(
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                  decoration: new InputDecoration(
                                      contentPadding: const EdgeInsets.all(20),
                                      fillColor: Colors.white,
                                      hintText: mail,
                                      hintStyle:
                                          TextStyle(color: Colors.white)),
                                  controller: contcmp4,
                                ),
                              ),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                child: DropdownButton(
                                    value: _value,
                                    isExpanded: true,
                                    style: new TextStyle(
                                        color: Colors.orange[900],
                                        fontWeight: FontWeight.w900),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("Administrador",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        value: 0,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Nutricionista",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("Kinesiologo",
                                              style: TextStyle(
                                                  color: Colors.orange[700])),
                                          value: 2),
                                      DropdownMenuItem(
                                          child: Text("Entrenador",
                                              style: TextStyle(
                                                  color: Colors.orange[700])),
                                          value: 3),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value = value;
                                      });
                                    }),
                              )
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                  flex: 20,
                                  child: new RaisedButton(
                                      child: new Text(
                                        "Ingresar",
                                        style:
                                            new TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.orange[700],
                                      onPressed: () {
                                        this.datos.operacion = "IngresarAdmin";
                                        this.datos.nombre = contcmp3.text;
                                        this.datos.mail = contcmp4.text;
                                        this.datos.tipo = categoria[_value];

                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ControllerUsuarios(
                                                      datos: datos,
                                                    )));
                                      })),
                            ]),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Expanded(
                                flex: 20,
                                child: new RaisedButton(
                                    child: new Text(
                                      "Cancelar",
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.orange[900],
                                    onPressed: () {
                                      Navigator.pop(
                                        context,
                                      );
                                    }),
                              ),
                            ]),
                      ]))
            ]),
          ),
        ),
      ),
    );
  }
}

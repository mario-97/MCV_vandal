import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/Controller/controllerEjercicio.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class AddRutina extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      home: Rutina(),
    );
  }
}

class Rutina extends StatefulWidget {
  @override
  _RutinaState createState() => _RutinaState();
}

class _RutinaState extends State<Rutina> {
  final Actividad datos = new Actividad("", "", "", "", "", "", "", "");

  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();
  final TextEditingController contcmp6 = new TextEditingController();
  final TextEditingController contcmp7 = new TextEditingController();
  final TextEditingController contcmp8 = new TextEditingController();
  final TextEditingController contcmp9 = new TextEditingController();

  var Docs;
  int _value = 1;
  int _value2 = 1;
  var categoria = [
    "Tonificar",
    "Perder peso",
    "Ganar masa muscular",
  ];
  var rep = [
    "5",
    "10",
    "15",
    "20",
    "25",
    "30",
    "35",
    "40",
    "45",
  ];
  bool existe = false;
  String link = "Ingrese link imagen";
  String id;
  String actividad = "Nombre de la actividad";
  String duracion = "Duracion";
  String kcalUsada = "Kcal quemadas";
  String tipo = "Tipo de ejercicios";
  String repeticiones = "Cantidad de repeticiones";

  @override
  Widget build(BuildContext context) {
    void registrar() async {
      await FirebaseFirestore.instance.collection("rutina").add({
        "actividad": contcmp3.text,
        "duracion": contcmp4.text,
        "kcalUsada": contcmp5.text,
        "tipo": categoria[_value],
        "repeticiones": rep[_value2],
        "imagen": contcmp6.text,
      }).then((value) => print(value.id));
      Navigator.pop(
        context,
      );
    }

    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      initialRoute: '/rutina',
      home: Scaffold(
        appBar: GradientAppBar(
          title: Text('Agregar Ejercicio'),
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
                                      hintText: actividad,
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
                                      hintText: duracion,
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
                                child: new TextField(
                                  style: new TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w900),
                                  decoration: new InputDecoration(
                                      contentPadding: const EdgeInsets.all(20),
                                      fillColor: Colors.white,
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: kcalUsada),
                                  controller: contcmp5,
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
                                      hintStyle: TextStyle(color: Colors.white),
                                      hintText: link),
                                  controller: contcmp6,
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
                                        child: Text("Tonificar"),
                                        value: 0,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("Perder peso"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("Ganar masa muscular"),
                                          value: 2),
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
                                child: DropdownButton(
                                    value: _value2,
                                    isExpanded: true,
                                    style: new TextStyle(
                                        color: Colors.orange[900],
                                        fontWeight: FontWeight.w900),
                                    items: [
                                      DropdownMenuItem(
                                        child: Text("5"),
                                        value: 0,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("10"),
                                        value: 1,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("15"), value: 2),
                                      DropdownMenuItem(
                                        child: Text("20"),
                                        value: 3,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("25"),
                                        value: 4,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("30"), value: 5),
                                      DropdownMenuItem(
                                        child: Text("35"),
                                        value: 6,
                                      ),
                                      DropdownMenuItem(
                                        child: Text("40"),
                                        value: 7,
                                      ),
                                      DropdownMenuItem(
                                          child: Text("45"), value: 8),
                                    ],
                                    onChanged: (value) {
                                      setState(() {
                                        _value2 = value;
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
                                      style: new TextStyle(color: Colors.white),
                                    ),
                                    color: Colors.orange[800],
                                    onPressed: () {
                                      this.datos.operacion = "Registrar";
                                      this.datos.actividad = contcmp3.text;
                                      this.datos.duracion = contcmp4.text;
                                      this.datos.kcalUsada = contcmp5.text;
                                      this.datos.imagen = contcmp6.text;
                                      this.datos.repeticiones = rep[_value2];
                                      this.datos.tipo = categoria[_value];
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ControllerEjercicio(
                                                    datos: datos,
                                                  )));
                                    }),
                              ),
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
                                      Navigator.pop(context);
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

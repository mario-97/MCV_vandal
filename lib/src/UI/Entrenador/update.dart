import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvp_vandal/src/UI/entrenador/listejercicios.dart';
import 'package:mvp_vandal/src/UI/entrenador/detalle.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/Controller/controllerEjercicio.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class UpdateEjercicio extends StatelessWidget {
  final Actividad data;
  UpdateEjercicio({this.data});
  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();
  final TextEditingController contcmp6 = new TextEditingController();
  final TextEditingController contcmp7 = new TextEditingController();
  final TextEditingController contcmp8 = new TextEditingController();

  var documento;
  int _value = 1;
  int _value2 = 1;
  var categoria = [
    "Tonificar",
    "Perder peso",
    "Ganar masa corporal",
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
  String link = "Link de la nueva imagen";
  String actividad = "Nombre de la actividad";
  String duracion = "Duracion";
  String kcalUsada = "Kcal quemadas";
  String tipo = "Tipo de ejercicios";
  String repeticiones = "Cantidad de repeticiones";
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("rutina");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/detalle',
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text('Modificar Ejercicio'),
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
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: <Widget>[
                          Expanded(
                              child: StreamBuilder<QuerySnapshot>(
                                  stream: query.snapshots(),
                                  builder: (context, stream) {
                                    if (stream.connectionState ==
                                        ConnectionState.waiting) {
                                      return Center(
                                          child: CircularProgressIndicator());
                                    }
                                    if (stream.hasError) {
                                      return Center(
                                          child: Text(stream.error.toString()));
                                    }
                                    QuerySnapshot querySnapshot = stream.data;
                                    for (var Docs in querySnapshot.docs) {
                                      if (Docs.id == data.id) {
                                        if (Docs.get("actividad") != "") {
                                          data.actividad =
                                              Docs.get("actividad");
                                        }
                                        if (Docs.get("duracion") != "") {
                                          data.duracion = Docs.get("duracion");
                                        }
                                        if (Docs.get("kcalUsada") != "") {
                                          data.kcalUsada =
                                              Docs.get("kcalUsada");
                                        }
                                        if (Docs.get("repeticiones") != "") {
                                          data.repeticiones =
                                              Docs.get("repeticiones");
                                        }
                                        if (Docs.get("tipo") != "") {
                                          data.tipo = Docs.get("tipo");
                                        }
                                        if (Docs.get("imagen") != "") {
                                          data.imagen = Docs.get("imagen");
                                        }
                                      }
                                    }

                                    return Container(
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Image(
                                                  image: new AssetImage(
                                                      'assets/images/2.png'),
                                                  height: 120,
                                                  alignment: Alignment.center),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintText:
                                                                data.actividad,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        controller: contcmp3,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintText:
                                                                data.duracion,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        controller: contcmp4,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            hintText:
                                                                data.kcalUsada),
                                                        controller: contcmp5,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            hintText:
                                                                data.tipo),
                                                        controller: contcmp6,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            hintText: data
                                                                .repeticiones),
                                                        controller: contcmp7,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            hintText:
                                                                data.imagen),
                                                        controller: contcmp8,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 20,
                                                      child: new RaisedButton(
                                                          child: new Text(
                                                            "Actualizar",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[800],
                                                          onPressed: () {
                                                            this
                                                                    .data
                                                                    .operacion =
                                                                "Actualizar";
                                                            if (contcmp3.text !=
                                                                "") {
                                                              this
                                                                      .data
                                                                      .actividad =
                                                                  contcmp3.text;
                                                            }
                                                            if (contcmp4.text !=
                                                                "") {
                                                              this
                                                                      .data
                                                                      .duracion =
                                                                  contcmp4.text;
                                                            }
                                                            if (contcmp5.text !=
                                                                "") {
                                                              this
                                                                      .data
                                                                      .kcalUsada =
                                                                  contcmp5.text;
                                                            }
                                                            if (contcmp6.text !=
                                                                "") {
                                                              this.data.tipo =
                                                                  contcmp6.text;
                                                            }
                                                            if (contcmp7.text !=
                                                                "") {
                                                              this
                                                                      .data
                                                                      .repeticiones =
                                                                  contcmp7.text;
                                                            }
                                                            if (contcmp8.text !=
                                                                "") {
                                                              this.data.imagen =
                                                                  contcmp8.text;
                                                            }

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ControllerEjercicio(
                                                                              datos: data,
                                                                            )));
                                                          }),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 20,
                                                      child: new RaisedButton(
                                                        child: new Text(
                                                          "Eliminar",
                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color:
                                                            Colors.orange[800],
                                                        onPressed: () {
                                                          this.data.operacion =
                                                              "Eliminar";
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ControllerEjercicio(
                                                                            datos:
                                                                                data,
                                                                          )));
                                                        },
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 20,
                                                      child: new RaisedButton(
                                                          child: new Text(
                                                            "Cancelar",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[900],
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Detalle(
                                                                              data: data,
                                                                            )));
                                                          }),
                                                    ),
                                                  ])
                                            ]));
                                  }))
                        ])))));
  }
}

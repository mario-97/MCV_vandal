import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/entrenador/listejercicios.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvp_vandal/src/UI/entrenador/update.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Detalle extends StatelessWidget {
  final Actividad data;

  Detalle({this.data});
  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();

  var documento;
  bool existe = false;
  String actividad = "Nombre de la actividad";
  String duracion = "Duracion";
  String kcalUsada = "Kcal quemadas";
  String tipo = "Tipo de ejercicios";
  String repeticiones = "Cantidad de repeticiones";
  String link;

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
        initialRoute: '/registro',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text('Detalle del Ejercicio'),
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
                                          link = Docs.get("imagen");
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
                                              new Image.network(link),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        enabled: false,
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
                                                                "Actividad:     " +
                                                                    data
                                                                        .actividad,
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
                                                        enabled: false,
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
                                                                "Duración:     " +
                                                                    data
                                                                        .duracion,
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
                                                        enabled: false,
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
                                                                "Kcal quemadas:     " +
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
                                                        enabled: false,
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
                                                                "Repeticiones:     " +
                                                                    data.repeticiones),
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
                                                        enabled: false,
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
                                                                "Tipo de ejercicio:   " +
                                                                    data.tipo),
                                                        controller: contcmp5,
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
                                                            "Modificar",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[800],
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            UpdateEjercicio(
                                                                              data: data,
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
                                                            "Volver",
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
                                                                            Ejercicios()));
                                                          }),
                                                    ),
                                                  ])
                                            ]));
                                  }))
                        ])))));
  }
}

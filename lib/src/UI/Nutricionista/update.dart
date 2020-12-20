import 'package:mvp_vandal/src/UI/nutricionista/dietas.dart';
import 'package:mvp_vandal/src/UI/nutricionista/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:mvp_vandal/src/Controller/controllerDietas.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class UpdateDieta extends StatelessWidget {
  final Minuta data;
  UpdateDieta({this.data});

  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();
  final TextEditingController contcmp6 = new TextEditingController();
  final TextEditingController contcmp7 = new TextEditingController();
  final TextEditingController contcmp8 = new TextEditingController();
  final TextEditingController contcmp9 = new TextEditingController();

  var documento;
  bool existe = false;
  String tipodieta = "Tipo dieta";
  String rangoedad = "rango etario";
  String desayuno = "desayuno";
  String almuerzo = "almuerzo";
  String cena = "cena";
  String merienda = "merienda";
  String calorias = "calorias consumidas";

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("dietas");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/updateDieta',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text('Editar Dieta'),
              backgroundColorStart: Colors.orange[900],
              backgroundColorEnd: Colors.amber,
            ),
            body: Center(
                child: Container(
                    height: MediaQuery.of(context).size.height,
                    width: double.infinity,
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
                                        if (Docs.get("tipodieta") != "") {
                                          data.tipodieta =
                                              Docs.get("tipodieta");
                                        }
                                        if (Docs.get("rangoedad") != "") {
                                          data.rangoedad =
                                              Docs.get("rangoedad");
                                        }
                                        if (Docs.get("desayuno") != "") {
                                          data.desayuno = Docs.get("desayuno");
                                        }
                                        if (Docs.get("almuerzo") != "") {
                                          data.almuerzo = Docs.get("almuerzo");
                                        }
                                        if (Docs.get("cena") != "") {
                                          data.cena = Docs.get("cena");
                                        }
                                        if (Docs.get("merienda") != "") {
                                          data.merienda = Docs.get("merienda");
                                        }
                                        if (Docs.get("calorias") != "") {
                                          data.calorias = Docs.get("calorias");
                                        }
                                      }
                                    }

                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: double.infinity,
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            children: <Widget>[
                                              new Image(
                                                  image: new AssetImage(
                                                      'assets/images/2.png'),
                                                  height: 90,
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
                                                                data.tipodieta,
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
                                                                data.rangoedad,
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
                                                                data.desayuno),
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
                                                                data.almuerzo),
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
                                                            hintText:
                                                                data.cena),
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
                                                                data.merienda),
                                                        controller: contcmp8,
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
                                                                data.calorias),
                                                        controller: contcmp9,
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
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color:
                                                            Colors.orange[800],
                                                        onPressed: () {
                                                          data.operacion =
                                                              "Actualizar";
                                                          if (contcmp3.text !=
                                                              "") {
                                                            this
                                                                    .data
                                                                    .tipodieta =
                                                                contcmp3.text;
                                                          }
                                                          if (contcmp4.text !=
                                                              "") {
                                                            this
                                                                    .data
                                                                    .rangoedad =
                                                                contcmp4.text;
                                                          }
                                                          if (contcmp5.text !=
                                                              "") {
                                                            this.data.desayuno =
                                                                contcmp5.text;
                                                          }
                                                          if (contcmp6.text !=
                                                              "") {
                                                            this.data.almuerzo =
                                                                contcmp6.text;
                                                          }
                                                          if (contcmp7.text !=
                                                              "") {
                                                            this.data.cena =
                                                                contcmp7.text;
                                                          }
                                                          if (contcmp8.text !=
                                                              "") {
                                                            this.data.merienda =
                                                                contcmp8.text;
                                                          }
                                                          if (contcmp9.text !=
                                                              "") {
                                                            this.data.calorias =
                                                                contcmp9.text;
                                                          }
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ControllerDietas(
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
                                                          "Eliminar",
                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color:
                                                            Colors.orange[800],
                                                        onPressed: () {
                                                          data.operacion =
                                                              "Eliminar";
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder:
                                                                      (context) =>
                                                                          ControllerDietas(
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
                                                                            HomeNutri()));
                                                          }),
                                                    ),
                                                  ])
                                            ]));
                                  }))
                        ])))));
  }
}

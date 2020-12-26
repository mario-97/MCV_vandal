import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/tipoDietas.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minutaCliente.dart';
import 'package:mvp_vandal/src/UI/nutricionista/update.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/tipoDietas.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/DetalleSelect.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/GraficoT.dart';

int caloriasTotales;

class DietaSelect extends StatefulWidget {
  _DietaSelectState createState() => _DietaSelectState();
}

class _DietaSelectState extends State<DietaSelect> {
  final MinutaCliente datos =
      new MinutaCliente("", "", "", "", "", "", "", "", "", "", "");

  int caloriasTotales = 0;

  List<String> dias = [
    "Lunes",
    "Martes",
    "Miercoles",
    "Jueves",
    "Viernes",
    "Sabado",
    "Domingo"
  ];

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("dietasCliente");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/registro',
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                appBar: GradientAppBar(
                  title: Text("Listado de dietas seleccionadas"),
                  backgroundColorStart: Colors.orange[900],
                  backgroundColorEnd: Colors.orange,
                  bottom: TabBar(
                    tabs: [
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.subject)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TipoDietasCliente()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.calendar_today)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DietaSelect()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.show_chart)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GraficoTT()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.home_outlined)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                        username: googleSignIn
                                            .currentUser.displayName)));
                          }),
                    ],
                  ),
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
                        Colors.orange,
                        Colors.orange[700],
                        Colors.orange[800],
                        Colors.orange[900]
                      ])),
                  child: Column(children: <Widget>[
                    Expanded(
                        flex: 20,
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
                                if (Docs.data()["idCliente"] ==
                                    googleSignIn.currentUser.id)
                                  caloriasTotales = caloriasTotales +
                                      int.parse(Docs.data()["calorias"]);
                              }
                              return ListView(children: <Widget>[
                                for (var Docs in querySnapshot.docs)
                                  Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 2),
                                      elevation: 10,
                                      child: Column(children: [
                                        if (Docs.data()["idCliente"] ==
                                            googleSignIn.currentUser.id)
                                          Column(
                                            children: [
                                              ListTile(
                                                  title: new Text(
                                                      dias[(int.parse(
                                                                  Docs.data()[
                                                                      "dia"]) -
                                                              1) %
                                                          7],
                                                      style: TextStyle(
                                                          color: Colors
                                                              .orange[700])),
                                                  subtitle: Text(
                                                      "Edad recomendada: " +
                                                          Docs.data()[
                                                              "rangoedad"] +
                                                          "\n" +
                                                          "Calorias: " +
                                                          Docs.data()[
                                                              "calorias"]),
                                                  leading: CircleAvatar(
                                                    backgroundColor:
                                                        Color(0xfff57c00),
                                                    radius: 30,
                                                    child: Icon(
                                                      Icons.fastfood,
                                                      color: Colors.white,
                                                    ),
                                                  ),
                                                  onTap: () {
                                                    datos.id = Docs.id;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                DetalleSelect(
                                                                  data: datos,
                                                                )));
                                                  }),
                                            ],
                                          )
                                      ])),
                                Container(
                                    margin: EdgeInsets.all(5),
                                    child: Row(children: <Widget>[
                                      Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Container(
                                                margin: EdgeInsets.all(1),
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    4,
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .height /
                                                    2,
                                                child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(1),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    9.5,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3,
                                                                child: Card(
                                                                    color: Colors
                                                                            .orange[
                                                                        400],
                                                                    semanticContainer:
                                                                        true,
                                                                    clipBehavior:
                                                                        Clip
                                                                            .antiAliasWithSaveLayer,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    elevation:
                                                                        10,
                                                                    margin: EdgeInsets
                                                                        .all(0),
                                                                    child:
                                                                        ListTile(
                                                                      title: new Text(
                                                                          "Calorias promedio diarias: ",
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                      subtitle: Text(
                                                                          (caloriasTotales / 7).toStringAsFixed(
                                                                              2),
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                    )))
                                                          ]),
                                                      Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Container(
                                                                margin:
                                                                    EdgeInsets
                                                                        .all(1),
                                                                height: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .height /
                                                                    9.5,
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width /
                                                                    3,
                                                                child: Card(
                                                                    color: Colors
                                                                            .orange[
                                                                        600],
                                                                    semanticContainer:
                                                                        true,
                                                                    clipBehavior:
                                                                        Clip
                                                                            .antiAliasWithSaveLayer,
                                                                    shape:
                                                                        RoundedRectangleBorder(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              10.0),
                                                                    ),
                                                                    elevation:
                                                                        10,
                                                                    margin: EdgeInsets
                                                                        .all(0),
                                                                    child:
                                                                        ListTile(
                                                                      title: new Text(
                                                                          "Calorias totales Semanal: ",
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                      subtitle: Text(
                                                                          caloriasTotales.toStringAsFixed(
                                                                              2),
                                                                          style:
                                                                              TextStyle(color: Colors.white)),
                                                                    )))
                                                          ]),
                                                    ]))
                                          ]),
                                    ])),
                              ]);
                            })),
                  ]),
                )))));
  }
}

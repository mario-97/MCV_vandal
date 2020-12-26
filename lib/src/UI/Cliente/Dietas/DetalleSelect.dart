import 'package:mvp_vandal/src/UI/Cliente/Dietas/DietasSelect.dart';
import 'package:mvp_vandal/src/UI/nutricionista/dietas.dart';
import 'package:mvp_vandal/src/UI/nutricionista/home.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:mvp_vandal/src/Controller/controllerDietasCliente.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/DietasHome.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/datos/minutaCliente.dart';

class DetalleSelect extends StatelessWidget {
  @override
  final MinutaCliente data;
  DetalleSelect({this.data});

  var documento;
  bool existe = false;
  String tipodieta = "Tipo dieta";
  String rangoedad = "rango etario";
  String desayuno = "desayuno";
  String almuerzo = "almuerzo";
  String cena = "cena";
  String merienda = "merienda";
  String calorias = "calorias consumidas";
  String dia = "dia elegido";

  @override
  Widget build(BuildContext context) {
    Query query =
        FirebaseFirestore.instance.collection("dietasCliente").orderBy("dia");

    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/DetalleDieta',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text('Detalle Dieta'),
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
                                        if (Docs.get("dia") != "") {
                                          data.dia = Docs.get("dia");
                                        }
                                      }
                                    }

                                    return Container(
                                        height:
                                            MediaQuery.of(context).size.height,
                                        width: double.infinity,
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 25.0),
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
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Tipo de dieta: " +
                                                                            data
                                                                                .tipodieta,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Edad recomendada: " +
                                                                            data
                                                                                .rangoedad,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Desayuno: " +
                                                                            data
                                                                                .desayuno,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Almuerzo: " +
                                                                            data
                                                                                .almuerzo,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Cena: " +
                                                                            data
                                                                                .cena,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Merienda: " +
                                                                            data
                                                                                .merienda,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Calorias Consumidas: " +
                                                                            data
                                                                                .calorias,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                        flex: 1,
                                                        child: Card(
                                                          child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(10),
                                                              child: Column(
                                                                  children: [
                                                                    Text(
                                                                        "Dia elegido: " +
                                                                            data
                                                                                .dia,
                                                                        style:
                                                                            TextStyle(
                                                                          color:
                                                                              Colors.black,
                                                                          fontSize:
                                                                              15,
                                                                          fontWeight:
                                                                              FontWeight.w500,
                                                                        ))
                                                                  ])),
                                                          color: Colors
                                                              .orange[200],
                                                          semanticContainer:
                                                              true,
                                                          clipBehavior: Clip
                                                              .antiAliasWithSaveLayer,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        50.0),
                                                          ),
                                                          elevation: 5,
                                                          margin:
                                                              EdgeInsets.all(5),
                                                        ))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 20,
                                                      child: new RaisedButton(
                                                          child: new Text(
                                                            "Eliminar dieta",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors.black12,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          onPressed: () {
                                                            this
                                                                    .data
                                                                    .operacion =
                                                                "Eliminar";
                                                            this.data.id =
                                                                data.id;

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ControllerDietasCliente(
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
                                                            "Atras",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors.black12,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20.0),
                                                          ),
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            DietaSelect()));
                                                          }),
                                                    ),
                                                  ])
                                            ]));
                                  })),
                        ])))));
  }
}

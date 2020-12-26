import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/Entrenador/listejercicios.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mvp_vandal/src/UI/Cliente/GraficoT.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Metas.dart';

class ResumenT extends StatelessWidget {
  final InfoEjercicio datos;
  ResumenT({this.datos});

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance
        .collection("Resumen")
        .orderBy("id_incremental");

    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/resumenT',
        routes: {
          '/controller': (context) => UserController(datos: this.datos),
        },
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 6,
            child: Scaffold(
                // termina barra drawer
                appBar: GradientAppBar(
                  title: Text("Resumen de actividad fisica"),
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
                                    builder: (context) => Ejercicios()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.flag)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MetasT()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.offline_pin)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Selecc()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.analytics)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resumen()));
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
                              Colors.orange,
                              Colors.orange[700],
                              Colors.orange[800],
                              Colors.orange[900]
                            ])),
                        child: Column(children: <Widget>[
                          Expanded(
                              flex: 10,
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
                                              if (Docs.data()["id_cliente"] ==
                                                      id &&
                                                  rol == "Cliente")
                                                Column(children: [
                                                  ListTile(
                                                    title: new Text(
                                                        "Día: " +
                                                            (Docs.data()[
                                                                        "id_incremental"] +
                                                                    1)
                                                                .toString(),
                                                        style: TextStyle(
                                                            color: Colors
                                                                .orange[700])),
                                                    subtitle: Text(
                                                        "Calorías gastadas: " +
                                                            Docs.data()[
                                                                "totalkcal"] +
                                                            "\nTiempo Ejercitado: " +
                                                            Docs.data()[
                                                                "totaltiempo"]),
                                                  ),
                                                ]),
                                            ]))
                                    ]);
                                  })),
                          if (rol == "Cliente")
                            Container(
                                child: Row(children: <Widget>[
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Container(
                                        margin: EdgeInsets.all(20),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                4,
                                        width:
                                            MediaQuery.of(context).size.height /
                                                5,
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.all(
                                                            1),
                                                        height: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                        width: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                        child: Card(
                                                            color:
                                                                Colors
                                                                        .orange[
                                                                    400],
                                                            semanticContainer:
                                                                true,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            elevation: 10,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: ListTile(
                                                              title: new Text(
                                                                  "Gasto Kcal: ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              subtitle: Text(
                                                                  datos
                                                                      .totalkcal,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            )))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin:
                                                            EdgeInsets.all(1),
                                                        height:
                                                            MediaQuery.of(context)
                                                                    .size
                                                                    .height /
                                                                14,
                                                        width: MediaQuery.of(
                                                                    context)
                                                                .size
                                                                .width /
                                                            3,
                                                        child: Card(
                                                            color:
                                                                Colors.orange,
                                                            semanticContainer:
                                                                true,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            elevation: 10,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: ListTile(
                                                              title: new Text(
                                                                  "Tiempo (Min): ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              subtitle: Text(
                                                                  datos
                                                                      .totaltiempo,
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            )))
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    Container(
                                                        margin: EdgeInsets.all(
                                                            1),
                                                        height: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .height /
                                                            14,
                                                        width: MediaQuery
                                                                    .of(context)
                                                                .size
                                                                .width /
                                                            3,
                                                        child: Card(
                                                            color:
                                                                Colors
                                                                        .orange[
                                                                    600],
                                                            semanticContainer:
                                                                true,
                                                            clipBehavior: Clip
                                                                .antiAliasWithSaveLayer,
                                                            shape:
                                                                RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          10.0),
                                                            ),
                                                            elevation: 10,
                                                            margin:
                                                                EdgeInsets.all(
                                                                    0),
                                                            child: ListTile(
                                                              title: new Text(
                                                                  "Dias: ",
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                              subtitle: Text(
                                                                  (int.parse(datos
                                                                              .nombre) +
                                                                          1)
                                                                      .toString(),
                                                                  style: TextStyle(
                                                                      color: Colors
                                                                          .white)),
                                                            )))
                                                  ])
                                            ]))
                                  ]),
                              Container(
                                  margin: EdgeInsets.all(5),
                                  child: Row(children: <Widget>[
                                    Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Container(
                                              margin: EdgeInsets.all(20),
                                              height: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  4,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .height /
                                                  5,
                                              child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              margin:
                                                                  EdgeInsets
                                                                      .all(1),
                                                              height: MediaQuery
                                                                          .of(
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
                                                                  elevation: 10,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  child:
                                                                      ListTile(
                                                                    title: new Text(
                                                                        "Kcal promedio diarias: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    subtitle: Text(
                                                                        datos
                                                                            .kcal,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                  )))
                                                        ]),
                                                    Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          Container(
                                                              margin:
                                                                  EdgeInsets
                                                                      .all(1),
                                                              height: MediaQuery
                                                                          .of(
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
                                                                  elevation: 10,
                                                                  margin:
                                                                      EdgeInsets
                                                                          .all(
                                                                              0),
                                                                  child:
                                                                      ListTile(
                                                                    title: new Text(
                                                                        "Tiempo promedio diario: ",
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                    subtitle: Text(
                                                                        datos
                                                                            .tiempo,
                                                                        style: TextStyle(
                                                                            color:
                                                                                Colors.white)),
                                                                  )))
                                                        ]),
                                                  ]))
                                        ]),
                                  ])),
                            ]))
                        ]))))));
  }
}

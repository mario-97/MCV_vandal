import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/Entrenador/listejercicios.dart';
import 'package:mvp_vandal/src/UI/Cliente/GraficoT.dart';
import 'package:mvp_vandal/src/UI/Cliente/Metas.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

int totalkcal = 0;
int totaltiempo = 0;

class Seleccionados extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Selecc(),
    );
  }
}

class Selecc extends StatefulWidget {
  @override
  _SeleccState createState() => _SeleccState();
}

class _SeleccState extends State<Selecc> {
  final Actividad data = new Actividad("", "", "", "", "", "", "", "");
  final InfoEjercicio datos =
      new InfoEjercicio("", "", "", "", "", "", "", "", "", "", [], "", "");

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("ListaEjercicio");
    var swidth = MediaQuery.of(context).size.width;

    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/seleccionados',
        routes: {
          '/controller': (context) => UserController(datos: this.datos),
        },
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 6,
            child: Scaffold(
                // termina barra drawer
                appBar: GradientAppBar(
                  title: Text("Rutina de Ejercicios"),
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
                                              if (Docs.data()["estado"] ==
                                                      "Asignado" &&
                                                  Docs.data()["id_cliente"] ==
                                                      id &&
                                                  rol == "Cliente")
                                                Column(children: [
                                                  ListTile(
                                                      title: new Text(
                                                          Docs.data()["nombre"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange[
                                                                      700])),
                                                      subtitle: Text(
                                                          Docs.data()["Kcal"] +
                                                              " - duracion: " +
                                                              Docs.data()[
                                                                  "tiempo"]),
                                                      trailing: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons
                                                                        .check_circle_outline,
                                                                    size: 20.0,
                                                                    color: Colors
                                                                            .green[
                                                                        400]),
                                                                onPressed: () {
                                                                  this
                                                                          .datos
                                                                          .operacion =
                                                                      "Marcar";
                                                                  this
                                                                          .datos
                                                                          .idInfo =
                                                                      Docs.id;
                                                                  totalkcal = totalkcal +
                                                                      int.parse(
                                                                          Docs.get(
                                                                              "Kcal"));
                                                                  totaltiempo =
                                                                      totaltiempo +
                                                                          int.parse(
                                                                              Docs.get("tiempo"));
                                                                  Navigator.pushNamed(
                                                                      context,
                                                                      '/controller');
                                                                })
                                                          ])),
                                                ]),
                                              if (Docs.data()["estado"] ==
                                                      "Realizado" &&
                                                  Docs.data()["id_cliente"] ==
                                                      id &&
                                                  rol == "Cliente")
                                                Column(children: [
                                                  ListTile(
                                                      title: new Text(
                                                          Docs.data()["nombre"],
                                                          style: TextStyle(
                                                              color:
                                                                  Colors.orange[
                                                                      700])),
                                                      subtitle: Text(
                                                          Docs.data()["Kcal"] +
                                                              " - duracion: " +
                                                              Docs.data()[
                                                                  "tiempo"]),
                                                      trailing: Row(
                                                          mainAxisSize:
                                                              MainAxisSize.min,
                                                          children: <Widget>[
                                                            IconButton(
                                                                icon: Icon(
                                                                    Icons
                                                                        .check_circle,
                                                                    size: 20.0,
                                                                    color: Colors
                                                                            .green[
                                                                        400]),
                                                                onPressed:
                                                                    () {})
                                                          ])),
                                                ]),
                                            ])),
                                      if (rol == "Cliente")
                                        Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: <Widget>[
                                              Container(
                                                  margin: const EdgeInsets.only(
                                                    bottom: 60.0,
                                                  ),
                                                  child: Align(
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    child: SizedBox(
                                                      height: 54.0,
                                                      width: swidth / 1.45,
                                                      child: RaisedButton(
                                                          child: new Text(
                                                            "Terminar rutina",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors.amber,
                                                          onPressed: () {
                                                            this
                                                                    .datos
                                                                    .operacion =
                                                                "Terminar";
                                                            this
                                                                    .datos
                                                                    .totalkcal =
                                                                totalkcal
                                                                    .toString();
                                                            this
                                                                    .datos
                                                                    .totaltiempo =
                                                                totaltiempo
                                                                    .toString();
                                                            this
                                                                .datos
                                                                .idCliente = id;
                                                            totalkcal = 0;
                                                            totaltiempo = 0;
                                                            Navigator.pushNamed(
                                                                context,
                                                                '/controller');
                                                          }),
                                                    ),
                                                  ))
                                            ]),
                                    ]);
                                  })),
                          if (rol == "Cliente")
                            Text("Total kcal quemadas: " +
                                totalkcal.toString() +
                                "\n"),
                          if (rol == "Cliente")
                            Text("Tiempo Transcurrido: " +
                                totaltiempo.toString() +
                                "\n"),
                        ]))))));
  }
}

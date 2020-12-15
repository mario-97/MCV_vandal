import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/entrenador/detalle.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Ejercicios.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class RutinaDos extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Tres(),
    );
  }
}

class Tres extends StatefulWidget {
  @override
  _TresState createState() => _TresState();
}

class _TresState extends State<Tres> {
  final Actividad data = new Actividad("", "", "", "", "", "", "", "");
  final InfoEjercicio datos =
      new InfoEjercicio("", "", "", "", "", "", "", "", "", "", []);

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
        home: Scaffold(
            // termina barra drawer
            appBar: GradientAppBar(
              title: Text("Ejercicios para Ganar Masa"),
              backgroundColorStart: Colors.orange[900],
              backgroundColorEnd: Colors.orange,
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
                        if (stream.connectionState == ConnectionState.waiting) {
                          return Center(child: CircularProgressIndicator());
                        }
                        if (stream.hasError) {
                          return Center(child: Text(stream.error.toString()));
                        }
                        QuerySnapshot querySnapshot = stream.data;

                        return ListView(children: <Widget>[
                          for (var Docs in querySnapshot.docs)
                            Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)),
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 2),
                                elevation: 10,
                                child: Column(children: [
                                  if (Docs.data()["tipo"] ==
                                          "Ganar masa muscular" &&
                                      rol == "Entrenador")
                                    ListTile(
                                        title:
                                            new Text(Docs.data()["actividad"],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange[700])),
                                        subtitle: Text(
                                            Docs.data()["kcalUsada"] +
                                                " - " +
                                                "duracion: " +
                                                Docs.data()["duracion"]),
                                        leading: new Image.network(
                                            Docs.data()["imagen"]),
                                        onTap: () {
                                          data.id = Docs.id;
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Detalle(
                                                        data: data,
                                                      )));
                                        }),
                                  if (Docs.data()["tipo"] ==
                                          "Ganar masa muscular" &&
                                      rol == "Cliente" &&
                                      Docs.data()["estado"] == "Seleccionado")
                                    ListTile(
                                        title:
                                            new Text(Docs.data()["actividad"],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange[700])),
                                        subtitle: Text(
                                            Docs.data()["kcalUsada"] +
                                                " - " +
                                                "duracion: " +
                                                Docs.data()["duracion"]),
                                        leading: new Image.network(
                                            Docs.data()["imagen"]),
                                        trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.favorite_rounded,
                                                      size: 20.0,
                                                      color: Colors.green[400]),
                                                  onPressed: () {
                                                    this.datos.operacion =
                                                        "Eliminar";

                                                    this.datos.idEjercicio =
                                                        Docs.id;
                                                    this.datos.nombre =
                                                        Docs.get("actividad");
                                                    this.datos.kcal =
                                                        Docs.get("kcalUsada");
                                                    this.datos.tiempo =
                                                        Docs.get("duracion");
                                                    this.datos.idCliente = id;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserEjercicio(
                                                                  datos: this
                                                                      .datos,
                                                                )));
                                                  })
                                            ])),
                                  if (Docs.data()["tipo"] ==
                                          "Ganar masa muscular" &&
                                      rol == "Cliente" &&
                                      Docs.data()["estado"] ==
                                          "No seleccionado")
                                    ListTile(
                                        title:
                                            new Text(Docs.data()["actividad"],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange[700])),
                                        subtitle: Text(
                                            Docs.data()["kcalUsada"] +
                                                " - " +
                                                "duracion: " +
                                                Docs.data()["duracion"]),
                                        leading: new Image.network(
                                            Docs.data()["imagen"]),
                                        trailing: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: <Widget>[
                                              IconButton(
                                                  icon: Icon(
                                                      Icons.favorite_border,
                                                      size: 20.0,
                                                      color: Colors.green[400]),
                                                  onPressed: () {
                                                    this.datos.operacion =
                                                        "Ingresar";
                                                    this.datos.idEjercicio =
                                                        Docs.id;
                                                    this.datos.nombre =
                                                        Docs.get("actividad");
                                                    this.datos.kcal =
                                                        Docs.get("kcalUsada");
                                                    this.datos.tiempo =
                                                        Docs.get("duracion");
                                                    this.datos.idCliente = id;
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                UserEjercicio(
                                                                  datos: this
                                                                      .datos,
                                                                )));
                                                  })
                                            ])),
                                ]))
                        ]);
                      }))
            ])))));
  }
}

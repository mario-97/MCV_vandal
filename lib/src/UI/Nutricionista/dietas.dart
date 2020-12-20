import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/tipoDietas.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:mvp_vandal/src/UI/nutricionista/update.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class Dieta extends StatefulWidget {
  _DietaState createState() => _DietaState();
}

class _DietaState extends State<Dieta> {
  final Minuta datos = new Minuta("", "", "", "", "", "", "", "", "");

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
        initialRoute: '/registro',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text("Listado de dietas"),
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
                    flex: 20,
                    child: StreamBuilder<QuerySnapshot>(
                        stream: query.snapshots(),
                        builder: (context, stream) {
                          if (stream.connectionState ==
                              ConnectionState.waiting) {
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
                                  child: Column(
                                    children: [
                                      ListTile(
                                          title: new Text(
                                              "Tipo de dieta: " +
                                                  Docs.data()["tipodieta"],
                                              style: TextStyle(
                                                  color: Colors.orange[700])),
                                          subtitle: Text("Edad recomendada: " +
                                              Docs.data()["rangoedad"] +
                                              "\n" +
                                              "Calorias: " +
                                              Docs.data()["calorias"]),
                                          leading: CircleAvatar(
                                            backgroundColor: Color(0xfff57c00),
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
                                                        UpdateDieta(
                                                          data: datos,
                                                        )));
                                          }),
                                    ],
                                  ))
                          ]);
                        })),
              ]),
            ))));
  }
}

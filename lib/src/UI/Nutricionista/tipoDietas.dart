import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:mvp_vandal/src/UI/nutricionista/update.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/categorias/adelgazar.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/categorias/musculos.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/categorias/tonificar.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class TipoDietas extends StatefulWidget {
  _TipoDietasState createState() => _TipoDietasState();
}

class _TipoDietasState extends State<TipoDietas> {
  @override
  Widget build(BuildContext context) {
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
              title: Text("Categorias"),
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
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(15),
                    elevation: 10,
                    child: Column(children: <Widget>[
                      Image(
                          image:
                              new AssetImage('assets/images/perderpeso.jpg')),
                      ListTile(
                          title: new Text("Dietas para Perder peso",
                              style: TextStyle(color: Colors.orange[700])),
                          subtitle: Text("Baja en Carbohidratos y grasas"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DietaUno()));
                          }),
                    ]),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(15),
                    elevation: 10,
                    child: Column(children: <Widget>[
                      Image(
                          image:
                              new AssetImage('assets/images/tonificar2.jpg')),
                      ListTile(
                          title: new Text("Dietas para Tonificar",
                              style: TextStyle(color: Colors.orange[700])),
                          subtitle: Text("Dieta equilibrada"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DosDieta()));
                          }),
                    ]),
                  ),
                  Card(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    margin: EdgeInsets.all(15),
                    elevation: 10,
                    child: Column(children: <Widget>[
                      Image(
                          image: new AssetImage('assets/images/ganarmasa.jpg')),
                      ListTile(
                          title: new Text("Dietas para Ganar masa muscular",
                              style: TextStyle(color: Colors.orange[700])),
                          subtitle: Text("Sobrecarga de proteinas"),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => TresDieta()));
                          }),
                    ]),
                  )
                ]),
              ),
            )));
  }
}

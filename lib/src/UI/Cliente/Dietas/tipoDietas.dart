import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:mvp_vandal/src/UI/nutricionista/update.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/categorias/adelgazar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/categorias/musculos.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/categorias/tonificar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/DietasSelect.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/GraficoT.dart';

class TipoDietasCliente extends StatefulWidget {
  _TipoDietasClienteState createState() => _TipoDietasClienteState();
}

class _TipoDietasClienteState extends State<TipoDietasCliente> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                // termina barra drawer
                appBar: GradientAppBar(
                  title: Text("Categorias"),
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
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(children: <Widget>[
                                  Image(
                                      image: new AssetImage(
                                          'assets/images/perderpeso.jpg')),
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                        title: new Text(
                                            "Dietas para Perder peso",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DietaUno()));
                                        }),
                                  )
                                ]),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(children: <Widget>[
                                  Image(
                                      image: new AssetImage(
                                          'assets/images/tonificar2.jpg')),
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                        title: new Text("Dietas para Tonificar",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      DosDieta()));
                                        }),
                                  )
                                ]),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(children: <Widget>[
                                  Image(
                                      image: new AssetImage(
                                          'assets/images/ganarmasa.jpg')),
                                  Expanded(
                                    flex: 1,
                                    child: ListTile(
                                        title: new Text(
                                            "Dietas para Ganar masa muscular",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TresDieta()));
                                        }),
                                  )
                                ]),
                              )))
                    ]),
                  ),
                ))));
  }
}

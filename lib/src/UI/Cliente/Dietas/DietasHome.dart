import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/GraficoT.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/miapp.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/nutricionista/dietas.dart';
import 'package:mvp_vandal/src/UI/nutricionista/ingresarDieta.dart';
import 'package:mvp_vandal/src/splashscreen.dart';
import 'package:mvp_vandal/src/home.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/tipoDietas.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class DietasHomeCliente extends StatefulWidget {
  _DietasHomeClienteState createState() => _DietasHomeClienteState();
}

String rol;
String id;

class _DietasHomeClienteState extends State<DietasHomeCliente> {
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("usuarios");
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      initialRoute: '/dietasHomeCliente',
      routes: {
        //'/dietas': (context) => Dieta(),
        '/ingresarDieta': (context) => IngresarDieta(),
        '/home': (context) => SplashScreen(),
      },
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: GradientAppBar(
          title: Text("Dietas"),
          backgroundColorStart: Colors.orange[900],
          backgroundColorEnd: Colors.orange,
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
                              image: new AssetImage('assets/images/dieta.jpg')),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                                title: new Text("Categorias de Dietas",
                                    style:
                                        TextStyle(color: Colors.orange[700])),
                                subtitle: Text(
                                    "Perder peso, Tonificar, Ganar masa muscular"),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              TipoDietasCliente()));
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
                        height: MediaQuery.of(context).size.height / 4,
                        child: Column(children: <Widget>[
                          Image(
                              image:
                                  new AssetImage('assets/images/Resumen.jpg')),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                                title: new Text("Ver resumenes",
                                    style:
                                        TextStyle(color: Colors.orange[700])),
                                subtitle: Text("Gráficos y estadisticas "),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => GraficoTT()));
                                }),
                          )
                        ]),
                      ))),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                color: Colors.orange[900],
                elevation: 10,
                child: Column(children: <Widget>[
                  ListTile(
                      title: new Text("Volver",
                          style: new TextStyle(color: Colors.white),
                          textAlign: TextAlign.center),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen(
                                    username:
                                        googleSignIn.currentUser.displayName)));
                      }),
                ]),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}

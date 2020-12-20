import 'dart:async';
import 'package:mvp_vandal/src/UI/nutricionista/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:mvp_vandal/src/Controller/controllerDietas.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class IngresarDieta extends StatefulWidget {
  _IngresarDietaState createState() => _IngresarDietaState();
}

class _IngresarDietaState extends State<IngresarDieta> {
  final Minuta datos = new Minuta("", "", "", "", "", "", "", "", "");
  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();
  final TextEditingController contcmp6 = new TextEditingController();
  final TextEditingController contcmp7 = new TextEditingController();
  final TextEditingController contcmp8 = new TextEditingController();
  final TextEditingController contcmp9 = new TextEditingController();

  int _value = 1;
  var categoria = [
    "Tonificar",
    "Perder peso",
    "Ganar masa muscular",
  ];

  int _value2 = 1;
  var rango = ["15-25", "26-40", "41-50", "50+"];

  var Docs;
  bool existe = false;
  String id;
  String tipodieta = "Tipo dieta";
  String rangoedad = "rango etario";
  String desayuno = "desayuno";
  String almuerzo = "almuerzo";
  String cena = "cena";
  String merienda = "merienda";
  String calorias = "calorias consumidas";

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/ingresarDietas',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text('Ingresar Dieta'),
              backgroundColorStart: Colors.orange[900],
              backgroundColorEnd: Colors.amber,
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
                      Colors.amber[100],
                      Colors.amber[500],
                      Colors.amber[700],
                      Colors.amber[900]
                    ])),
                margin: new EdgeInsets.symmetric(horizontal: 0.0),
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      new Image(
                          height: 100,
                          image: new AssetImage('assets/images/2.png'),
                          alignment: Alignment.center),
                      Container(
                        margin: new EdgeInsets.symmetric(horizontal: 30.0),
                        child: Column(
                          children: <Widget>[
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new TextField(
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          fillColor: Colors.white,
                                          hintText: desayuno,
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      controller: contcmp5,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new TextField(
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          fillColor: Colors.white,
                                          hintText: almuerzo,
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      controller: contcmp6,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new TextField(
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          fillColor: Colors.white,
                                          hintText: cena,
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      controller: contcmp7,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new TextField(
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          fillColor: Colors.white,
                                          hintText: merienda,
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      controller: contcmp8,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: new TextField(
                                      style: new TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w900),
                                      decoration: new InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.all(20),
                                          fillColor: Colors.white,
                                          hintText: calorias,
                                          hintStyle:
                                              TextStyle(color: Colors.white)),
                                      controller: contcmp9,
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: DropdownButton(
                                        value: _value,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text("Tonificar",
                                                style: TextStyle(
                                                    color: Colors.orange[900])),
                                            value: 0,
                                          ),
                                          DropdownMenuItem(
                                            child: Text("Perder peso",
                                                style: TextStyle(
                                                    color: Colors.orange[900])),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                              child: Text("Ganar masa muscular",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.orange[900])),
                                              value: 2),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _value = value;
                                          });
                                        }),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    child: DropdownButton(
                                        value: _value2,
                                        items: [
                                          DropdownMenuItem(
                                            child: Text("15-25",
                                                style: TextStyle(
                                                    color: Colors.orange[900])),
                                            value: 0,
                                          ),
                                          DropdownMenuItem(
                                            child: Text("26-40",
                                                style: TextStyle(
                                                    color: Colors.orange[900])),
                                            value: 1,
                                          ),
                                          DropdownMenuItem(
                                              child: Text("41-50",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.orange[900])),
                                              value: 2),
                                          DropdownMenuItem(
                                              child: Text("50+",
                                                  style: TextStyle(
                                                      color:
                                                          Colors.orange[900])),
                                              value: 3),
                                        ],
                                        onChanged: (value) {
                                          setState(() {
                                            _value2 = value;
                                          });
                                        }),
                                  )
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 20,
                                    child: new RaisedButton(
                                      child: new Text(
                                        "Ingresar",
                                        style:
                                            new TextStyle(color: Colors.white),
                                      ),
                                      color: Colors.orange[700],
                                      onPressed: () {
                                        datos.operacion = "Ingresar";
                                        datos.tipodieta = categoria[_value];
                                        datos.rangoedad = rango[_value2];
                                        datos.desayuno = contcmp5.text;
                                        datos.almuerzo = contcmp6.text;

                                        datos.cena = contcmp7.text;

                                        datos.merienda = contcmp8.text;
                                        datos.calorias = contcmp9.text;
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ControllerDietas(
                                                      datos: datos,
                                                    )));
                                      },
                                    ),
                                  ),
                                ]),
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Expanded(
                                    flex: 20,
                                    child: new RaisedButton(
                                        child: new Text(
                                          "Cancelar",
                                          style: new TextStyle(
                                              color: Colors.white),
                                        ),
                                        color: Colors.orange[900],
                                        onPressed: () {
                                          Navigator.pop(context);
                                        }),
                                  ),
                                ]),
                          ],
                        ),
                      ),
                    ]),
              ),
            )));
  }
}

import 'dart:async';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/miapp.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/nutricionista/dietas.dart';
import 'package:mvp_vandal/src/UI/nutricionista/ingresarDieta.dart';
import 'package:mvp_vandal/src/splashscreen.dart';
import 'package:mvp_vandal/src/home.dart';
import 'package:mvp_vandal/src/UI/nutricionista/tipoDietas.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class HomeNutri extends StatefulWidget {
  _HomeNutriState createState() => _HomeNutriState();
}

class _HomeNutriState extends State<HomeNutri> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      initialRoute: '/homeNutri',
      routes: {
        //'/dietas': (context) => Dieta(),
        '/ingresarDieta': (context) => IngresarDieta(),
        '/home': (context) => SplashScreen(),
      },
      home: Scaffold(
        appBar: GradientAppBar(
          title: Text("Dietas"),
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
                  Image(image: new AssetImage('assets/images/dieta.jpg')),
                  ListTile(
                      title: new Text("Categorias de Dietas",
                          style: TextStyle(color: Colors.orange[700])),
                      subtitle:
                          Text("Perder peso, Tonificar, Ganar masa muscular"),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => TipoDietas()));
                      }),
                ]),
              ),
              Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                margin: EdgeInsets.all(15),
                elevation: 10,
                child: Column(children: <Widget>[
                  Image(image: new AssetImage('assets/images/agregar.jpg')),
                  ListTile(
                      title: new Text("Agregar nueva dieta",
                          style: TextStyle(color: Colors.orange[700])),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IngresarDieta()));
                      }),
                ]),
              ),
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

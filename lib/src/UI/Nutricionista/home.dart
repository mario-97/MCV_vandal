import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/nutricionista/ingresarDieta.dart';
import 'package:mvp_vandal/src/splashscreen.dart';
import 'package:mvp_vandal/src/UI/nutricionista/tipoDietas.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

import 'package:cloud_firestore/cloud_firestore.dart';

class HomeNutri extends StatefulWidget {
  _HomeNutriState createState() => _HomeNutriState();
}

String id;

class _HomeNutriState extends State<HomeNutri> {
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
      initialRoute: '/homeNutri',
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
                                          builder: (context) => TipoDietas()));
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
                                  new AssetImage('assets/images/agregar.jpg')),
                          Expanded(
                            flex: 1,
                            child: ListTile(
                                title: new Text("Agregar nueva dieta",
                                    style:
                                        TextStyle(color: Colors.orange[700])),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              IngresarDieta()));
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

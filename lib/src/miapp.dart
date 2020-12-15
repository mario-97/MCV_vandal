import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/user.dart';
import 'package:mvp_vandal/src/Controller/controllerUsuarios.dart';

class MiApp extends StatelessWidget {
  final Users datos = new Users("", "", "", "", "", "", "", "", "");
  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();
  final TextEditingController contcmp6 = new TextEditingController();
  final TextEditingController contcmp7 = new TextEditingController();
  final TextEditingController contcmp8 = new TextEditingController();
  final TextEditingController contcmp9 = new TextEditingController();
  var Docs;
  bool existe = false;
  String tipo;
  String id;
  String nombre = "Ingese su nombre";
  String mail = "Correo Electronico";
  String edad = "Edad";
  String sexo = "Sexo";
  String peso = "Peso (Kg)";
  String altura = "Altura (cm)";
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
        initialRoute: '/registro',
        home: Scaffold(
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
              child:
                  Column(mainAxisAlignment: MainAxisAlignment.start, children: <
                      Widget>[
                Expanded(
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
                          for (var Docs in querySnapshot.docs) {
                            if (googleSignIn.currentUser.email ==
                                Docs.data()["mail"]) {
                              this.datos.id = Docs.id;

                              existe = true;
                              if (Docs.get("nombre") != "") {
                                this.datos.nombre = Docs.get("nombre");
                              }
                              if (Docs.get("mail") != "") {
                                this.datos.mail = Docs.get("mail");
                              }
                              if (Docs.get("edad") != "") {
                                this.datos.edad = Docs.get("edad");
                              }
                              if (Docs.get("sexo") != "") {
                                this.datos.sexo = Docs.get("sexo");
                              }
                              if (Docs.get("peso") != "") {
                                this.datos.peso = Docs.get("peso");
                              }
                              if (Docs.get("altura") != "") {
                                this.datos.altura = Docs.get("altura");
                              }
                              if (Docs.get("tipo") != "") {
                                tipo = Docs.get("tipo");
                              }
                            }
                          }
                          return Container(
                              margin:
                                  new EdgeInsets.symmetric(horizontal: 30.0),
                              child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: <Widget>[
                                    new Image(
                                        image: new AssetImage(
                                            'assets/images/2.png'),
                                        height: 120,
                                        alignment: Alignment.center),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: new TextField(
                                              enabled: false,
                                              style: new TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900),
                                              decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  fillColor: Colors.white,
                                                  hintText: googleSignIn
                                                      .currentUser.displayName,
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          Expanded(
                                            child: new TextField(
                                              enabled: false,
                                              style: new TextStyle(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.w900),
                                              decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  fillColor: Colors.white,
                                                  hintText: googleSignIn
                                                      .currentUser.email,
                                                  hintStyle: TextStyle(
                                                      color: Colors.white)),
                                            ),
                                          ),
                                        ]),
                                    if (tipo == "Cliente")
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: new TextField(
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                                decoration: new InputDecoration(
                                                    contentPadding:
                                                        const EdgeInsets.all(
                                                            20),
                                                    fillColor: Colors.white,
                                                    hintStyle: TextStyle(
                                                        color: Colors.white),
                                                    hintText: edad),
                                                controller: contcmp5,
                                              ),
                                            ),
                                          ]),
                                    if (tipo == "Cliente")
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              child: new TextField(
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                  hintText: sexo,
                                                ),
                                                controller: contcmp6,
                                              ),
                                            ),
                                            Expanded(
                                              child: new TextField(
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                  hintText: peso,
                                                ),
                                                controller: contcmp7,
                                              ),
                                            ),
                                            Expanded(
                                              child: new TextField(
                                                style: new TextStyle(
                                                    color: Colors.white,
                                                    fontWeight:
                                                        FontWeight.w900),
                                                decoration: new InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets.all(20),
                                                  fillColor: Colors.white,
                                                  hintStyle: TextStyle(
                                                      color: Colors.white),
                                                  hintText: altura,
                                                ),
                                                controller: contcmp8,
                                              ),
                                            ),
                                          ]),
                                    if (existe == false)
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 20,
                                              child: new RaisedButton(
                                                  child: new Text(
                                                    "Ingresar",
                                                    style: new TextStyle(
                                                        color: Colors.white),
                                                  ),
                                                  color: Colors.orange[700],
                                                  onPressed: () {
                                                    this.datos.operacion =
                                                        "Ingresar";
                                                    this.datos.nombre =
                                                        googleSignIn.currentUser
                                                            .displayName;
                                                    this.datos.mail =
                                                        googleSignIn
                                                            .currentUser.email;
                                                    this.datos.edad =
                                                        contcmp5.text;
                                                    this.datos.sexo =
                                                        contcmp6.text;
                                                    this.datos.peso =
                                                        contcmp7.text;
                                                    this.datos.altura =
                                                        contcmp8.text;

                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                ControllerUsuarios(
                                                                  datos: datos,
                                                                )));
                                                  }),
                                            ),
                                          ]),
                                    if (existe == true)
                                      Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: <Widget>[
                                            Expanded(
                                              flex: 20,
                                              child: new RaisedButton(
                                                child: new Text(
                                                  "Modificar",
                                                  style: new TextStyle(
                                                      color: Colors.white),
                                                ),
                                                color: Colors.orange[700],
                                                onPressed: () {
                                                  this.datos.operacion =
                                                      "Modificar";
                                                  this.datos.nombre =
                                                      googleSignIn.currentUser
                                                          .displayName;
                                                  this.datos.mail = googleSignIn
                                                      .currentUser.email;
                                                  if (contcmp5.text != "") {
                                                    this.datos.edad =
                                                        contcmp5.text;
                                                  }
                                                  if (contcmp6.text != "") {
                                                    this.datos.sexo =
                                                        contcmp6.text;
                                                  }
                                                  if (contcmp7.text != "") {
                                                    this.datos.peso =
                                                        contcmp7.text;
                                                  }
                                                  if (contcmp8.text != "") {
                                                    this.datos.altura =
                                                        contcmp8.text;
                                                  }

                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ControllerUsuarios(
                                                                datos: datos,
                                                              )));
                                                },
                                              ),
                                            ),
                                          ]),
                                    Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                  ]));
                        })),
              ]),
            ),
          ),
        ));
  }
}

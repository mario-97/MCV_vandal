import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/admin/listauser.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvp_vandal/src/datos/user.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/Controller/controllerUsuarios.dart';

class UpdateAdmin extends StatelessWidget {
  final Users data;
  UpdateAdmin({this.data});
  final TextEditingController contcmp3 = new TextEditingController();
  final TextEditingController contcmp4 = new TextEditingController();
  final TextEditingController contcmp5 = new TextEditingController();

  var documento;
  bool existe = false;
  String nombre = "Nombre de usuario";
  String mail = "Correo Electronico";
  String tipo = "Tipo de usuario";

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("usuarios");
    void actualizar() async {
      if (contcmp3.text != "") {
        nombre = contcmp3.text;
      }
      if (contcmp4.text != "") {
        mail = contcmp4.text;
      }
      if (contcmp5.text != "") {
        tipo = contcmp5.text;
      }
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(data.id)
          .update({
        "nombre": nombre,
        "mail": mail,
        "tipo": tipo,
      }).then((_) {
        print("success!");
      });
      Navigator.pop(
        context,
      );
    }

    void eliminar() async {
      await FirebaseFirestore.instance
          .collection("usuarios")
          .doc(data.id)
          .delete()
          .then((_) {
        print("success!");
      });
      Navigator.pop(
        context,
      );
    }

    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/registro',
        routes: {
          '/lista': (context) => Lista(),
        },
        home: Scaffold(
            appBar: GradientAppBar(
              title: Text('Actualizar usuario '),
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
                          Expanded(
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
                                    for (var Docs in querySnapshot.docs) {
                                      if (Docs.id == data.id) {
                                        if (Docs.get("nombre") != "") {
                                          nombre = Docs.get("nombre");
                                        }
                                        if (Docs.get("mail") != "") {
                                          mail = Docs.get("mail");
                                        }
                                        if (Docs.get("tipo") != "") {
                                          tipo = Docs.get("tipo");
                                        }
                                      }
                                    }

                                    return Container(
                                        margin: new EdgeInsets.symmetric(
                                            horizontal: 30.0),
                                        child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
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
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintText: nombre,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        controller: contcmp3,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintText: mail,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white)),
                                                        controller: contcmp4,
                                                      ),
                                                    ),
                                                  ]),
                                              Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      child: new TextField(
                                                        style: new TextStyle(
                                                            color: Colors.white,
                                                            fontWeight:
                                                                FontWeight
                                                                    .w900),
                                                        decoration: new InputDecoration(
                                                            contentPadding:
                                                                const EdgeInsets
                                                                    .all(20),
                                                            fillColor:
                                                                Colors.white,
                                                            hintStyle: TextStyle(
                                                                color: Colors
                                                                    .white),
                                                            hintText: tipo),
                                                        controller: contcmp5,
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
                                                            "Actualizar",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[700],
                                                          onPressed: () {
                                                            this
                                                                    .data
                                                                    .operacion =
                                                                "ModificarAdmin";
                                                            if (contcmp3.text !=
                                                                "") {
                                                              this.data.nombre =
                                                                  contcmp3.text;
                                                            }
                                                            if (contcmp4.text !=
                                                                "") {
                                                              this.data.mail =
                                                                  contcmp4.text;
                                                            }
                                                            if (contcmp5.text !=
                                                                "") {
                                                              this.data.tipo =
                                                                  contcmp5.text;
                                                            }

                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ControllerUsuarios(
                                                                              datos: data,
                                                                            )));
                                                          }),
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
                                                            "Eliminar",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[700],
                                                          onPressed: () {
                                                            this
                                                                    .data
                                                                    .operacion =
                                                                "EliminarAdmin";
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            ControllerUsuarios(
                                                                              datos: data,
                                                                            )));
                                                          }),
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
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[900],
                                                          onPressed: () {
                                                            Navigator.pop(
                                                                context);
                                                          }),
                                                    ),
                                                  ])
                                            ]));
                                  }))
                        ])))));
  }
}

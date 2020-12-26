import 'package:flutter/material.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:mvp_vandal/src/UI/Cliente/Suscripcion.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

String estado = "No suscrito";

class Premium extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return PremiumT();
  }
}

class PremiumT extends State<Premium> {
  String estado = "No suscrito";
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("Ordenes");
    return MaterialApp(
        title: 'Flutter Credit Card View Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            resizeToAvoidBottomInset: true,
            appBar: GradientAppBar(
              title: Text('Suscripción Primium'),
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
                      Colors.white,
                      Colors.white,
                      Colors.white,
                      Colors.white
                    ])),
                height: MediaQuery.of(context).size.height,
                width: double.infinity,
                child: Column(children: <Widget>[
                  Expanded(
                      child: StreamBuilder<QuerySnapshot>(
                          stream: query.snapshots(),
                          builder: (context, stream) {
                            if (stream.connectionState ==
                                ConnectionState.waiting) {
                              return Center(child: CircularProgressIndicator());
                            }
                            if (stream.hasError) {
                              return Center(
                                  child: Text(stream.error.toString()));
                            }
                            QuerySnapshot querySnapshot = stream.data;
                            for (var Docs in querySnapshot.docs) {
                              if (id == Docs.data()["id_cliente"]) {
                                estado = "Suscrito";
                              }
                            }
                            return Container(
                                child: Column(
                              children: <Widget>[
                                new Image(
                                    image: new AssetImage(
                                        'assets/images/Premium.png'),
                                    height: 120,
                                    alignment: Alignment.center),
                                Expanded(
                                    flex: 1,
                                    child: Container(
                                        margin: EdgeInsets.only(bottom: 0),
                                        height:
                                            MediaQuery.of(context).size.height /
                                                12,
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1,
                                        color: Colors.white,
                                        child: Column(children: <Widget>[
                                          Image.network(
                                            googleSignIn.currentUser.photoUrl,
                                            height: 200.0,
                                            width: 200.0,
                                          ),
                                          Expanded(
                                              child: ListTile(
                                            title: Text(
                                                "Usuario: " +
                                                    googleSignIn.currentUser
                                                        .displayName +
                                                    "\n",
                                                style: TextStyle(
                                                    color: Colors.orange[700])),
                                            subtitle: Text(
                                                "Estado Suscripcion: " +
                                                    estado +
                                                    "\n"),
                                          )),
                                          if (estado == "No suscrito")
                                            Container(
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width /
                                                  2,
                                              child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: <Widget>[
                                                    Expanded(
                                                      flex: 20,
                                                      child: new RaisedButton(
                                                          child: new Text(
                                                            "Suscribir",
                                                            style: new TextStyle(
                                                                color: Colors
                                                                    .white),
                                                          ),
                                                          color: Colors
                                                              .orange[700],
                                                          onPressed: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            Suscripcion()));
                                                          }),
                                                    ),
                                                  ]),
                                            ),
                                          Container(
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: <Widget>[
                                                  Expanded(
                                                    flex: 20,
                                                    child: new RaisedButton(
                                                        child: new Text(
                                                          "Volver",
                                                          style: new TextStyle(
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                        color:
                                                            Colors.orange[700],
                                                        onPressed: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                  builder: (context) => HomeScreen(
                                                                      username: googleSignIn
                                                                          .currentUser
                                                                          .displayName)));
                                                        }),
                                                  ),
                                                ]),
                                          ),
                                        ]))),
                              ],
                            ));
                          }))
                ]),
              ),
            )));
  }
}

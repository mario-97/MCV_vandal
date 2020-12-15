import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/admin/update.dart';
import 'package:mvp_vandal/src/datos/user.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ListaUser extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      home: Lista(),
    );
  }
}

class Lista extends StatefulWidget {
  @override
  _ListaState createState() => _ListaState();
}

class _ListaState extends State<Lista> {
  final Users data = new Users("", "", "", "", "", "", "", "", "");

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
        initialRoute: '/lista',
        home: Scaffold(
            // termina barra drawer
            appBar: GradientAppBar(
              title: Text("Usuarios del Sistema"),
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
                    flex: 10,
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

                          return ListView(
                            children: <Widget>[
                              for (var Docs in querySnapshot.docs)
                                Card(
                                  child: Padding(
                                    padding: const EdgeInsets.all(0),
                                    child: Column(
                                      children: [
                                        if (Docs.data()["tipo"] != "Cliente")
                                          ListTile(
                                              title: new Text(
                                                  Docs.data()["nombre"],
                                                  style: TextStyle(
                                                      color:
                                                          Colors.orange[700])),
                                              subtitle: Text(
                                                  Docs.data()["mail"] +
                                                      " - " +
                                                      Docs.data()["tipo"]),
                                              leading: CircleAvatar(
                                                backgroundColor:
                                                    Color(0xFFF57C00),
                                                radius: 30,
                                                child: Icon(
                                                  Icons.person,
                                                  color: Colors.white,
                                                ),
                                              ),
                                              onTap: () {
                                                data.id = Docs.id;
                                                this.data.nombre =
                                                    Docs.get("nombre");
                                                this.data.mail =
                                                    Docs.get("mail");
                                                this.data.tipo =
                                                    Docs.get("tipo");
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            UpdateAdmin(
                                                              data: data,
                                                            )));
                                              }),
                                      ],
                                    ),
                                  ),
                                  color: Colors.white,
                                  semanticContainer: true,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                  elevation: 5,
                                  margin: EdgeInsets.all(5),
                                ),
                            ],
                          );
                        })),
              ]),
            ))));
  }
}

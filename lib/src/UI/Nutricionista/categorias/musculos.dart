import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/entrenador/detalle.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/update.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/dietaCliente.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class DietaTres extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: TresDieta(),
    );
  }
}

class TresDieta extends StatefulWidget {
  @override
  _TresDietaState createState() => _TresDietaState();
}

class _TresDietaState extends State<TresDieta> {
  final Minuta data = new Minuta("", "", "", "", "", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("dietas");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            // termina barra drawer
            appBar: GradientAppBar(
              title: Text("Dietas para Ganar Masa"),
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
                                  return Center(
                                      child: CircularProgressIndicator());
                                }
                                if (stream.hasError) {
                                  return Center(
                                      child: Text(stream.error.toString()));
                                }
                                QuerySnapshot querySnapshot = stream.data;

                                return ListView(children: <Widget>[
                                  for (var Docs in querySnapshot.docs)
                                    Card(
                                        shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10)),
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 2),
                                        elevation: 10,
                                        child: Column(children: [
                                          if (Docs.data()["tipodieta"] ==
                                              "Ganar masa muscular")
                                            ListTile(
                                                title: new Text(
                                                    "Tipo de dieta: " +
                                                        Docs.data()[
                                                            "tipodieta"],
                                                    style: TextStyle(
                                                        color: Colors
                                                            .orange[700])),
                                                subtitle: Text(
                                                    "Edad recomendada: " +
                                                        Docs.data()[
                                                            "rangoedad"] +
                                                        "\n" +
                                                        "Calorias: " +
                                                        Docs.data()[
                                                            "calorias"]),
                                                leading: CircleAvatar(
                                                  backgroundColor:
                                                      Color(0xfff57c00),
                                                  radius: 25,
                                                  child: Icon(
                                                    Icons.fastfood,
                                                    color: Colors.white,
                                                  ),
                                                ),
                                                onTap: () {
                                                  data.id = Docs.id;
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              DietaCliente(
                                                                data: data,
                                                              )));
                                                }),
                                        ]))
                                ]);
                              }))
                    ])))));
  }
}

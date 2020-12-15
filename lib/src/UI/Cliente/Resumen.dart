import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:mvp_vandal/src/UI/Cliente/ResumenT.dart';
import 'package:loading_animations/loading_animations.dart';

class Resumentotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Resumen(),
    );
  }
}

class Resumen extends StatefulWidget {
  @override
  _ResumenState createState() => _ResumenState();
}

class _ResumenState extends State<Resumen> {
  int totalk = 0;
  int dias = 0;
  int totalt = 0;
  double kcalpromedio = 0;
  double tiempopromedio = 0;
  final Actividad data = new Actividad("", "", "", "", "", "", "", "");
  final InfoEjercicio datos =
      new InfoEjercicio("", "", "", "", "", "", "", "", "", "", []);

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("Resumen");

    void estadisticas() async {
      await FirebaseFirestore.instance
          .collection("Estadistica")
          .doc("estadistica")
          .update({
        "dias": dias.toString(),
        "kcalpromedio": kcalpromedio.toString(),
        "tiempopromedio": tiempopromedio.toString(),
        "totalk": totalk.toString(),
        "totalt": totalt.toString(),
      }).then((_) {
        print("success!" + this.datos.idInfo);
      });
      this.datos.kcal = kcalpromedio.toString();
      this.datos.tiempo = tiempopromedio.toString();
      this.datos.nombre = dias.toString();
      this.datos.totalkcal = totalk.toString();
      this.datos.totaltiempo = totalt.toString();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => ResumenT(datos: this.datos)));
    }

    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.cyan[600],
        ),
        initialRoute: '/resumen',
        routes: {
          '/controller': (context) => UserController(datos: this.datos),
        },
        home: Scaffold(
            // termina barra drawer

            body: Column(children: <Widget>[
          Expanded(
              flex: 10,
              child: StreamBuilder<QuerySnapshot>(
                  stream: query.snapshots(),
                  builder: (context, stream) {
                    if (stream.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    }
                    if (stream.hasError) {
                      return Center(child: Text(stream.error.toString()));
                    }
                    QuerySnapshot querySnapshot = stream.data;

                    for (var Docs in querySnapshot.docs) {
                      if (Docs.data()["id_cliente"] == id) {
                        totalk = totalk + int.parse(Docs.data()["totalkcal"]);
                        totalt = totalt + int.parse(Docs.data()["totaltiempo"]);
                        dias = dias + 1;
                      }
                    }
                    kcalpromedio = (totalk.toDouble() / dias);
                    tiempopromedio = (totalt.toDouble() / dias);
                    estadisticas();

                    return Container(
                        child: LoadingFlipping.circle(
                      borderColor: Colors.cyan,
                      borderSize: 3.0,
                      size: 30.0,
                      backgroundColor: Colors.cyanAccent,
                      duration: Duration(milliseconds: 500),
                    ));
                  })),
        ])));
  }
}

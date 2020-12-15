import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/UI/Entrenador/listejercicios.dart';
import 'package:mvp_vandal/src/authscreen.dart';

class GraficoTotal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: GraficoTT(),
    );
  }
}

class GraficoTT extends StatefulWidget {
  @override
  _GraficoTTState createState() => _GraficoTTState();
}

class _GraficoTTState extends State<GraficoTT> {
  List<Grafico> lista = [];
  int dias = 0;

  final InfoEjercicio datos =
      new InfoEjercicio("", "", "", "", "", "", "", "", "", "", []);
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("Resumen");

    _getSeriesData() {
      List<charts.Series<Grafico, int>> series = [
        charts.Series(
            id: "kcal",
            data: lista,
            domainFn: (Grafico series, _) => series.dias,
            measureFn: (Grafico series, _) => series.kcal,
            colorFn: (Grafico series, _) =>
                charts.MaterialPalette.blue.shadeDefault)
      ];
      return series;
    }

    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        home: DefaultTabController(
            length: 5,
            child: Scaffold(
                // termina barra drawer
                appBar: GradientAppBar(
                  title: Text('Calorias quemadas'),
                  backgroundColorStart: Colors.orange[900],
                  backgroundColorEnd: Colors.amber,
                  bottom: TabBar(
                    tabs: [
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.subject)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Ejercicios()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.offline_pin)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Selecc()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.analytics)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Resumen()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.show_chart)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => GraficoTT()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.home_outlined)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => HomeScreen(
                                        username: googleSignIn
                                            .currentUser.displayName)));
                          }),
                    ],
                  ),
                ),
                body: Column(children: <Widget>[
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
                              return Center(
                                  child: Text(stream.error.toString()));
                            }
                            QuerySnapshot querySnapshot = stream.data;

                            for (var Docs in querySnapshot.docs) {
                              if (Docs.data()["id_cliente"] == id &&
                                  rol == "Cliente") {
                                lista.add(new Grafico(
                                    int.parse(Docs.data()["totalkcal"]), dias));
                                dias = dias + 1;
                              }
                            }

                            return Container(
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                    Colors.orange[900],
                                    Colors.amber
                                  ])),
                              height: 400,
                              padding: EdgeInsets.all(40),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Calorias quemadas por Día",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: charts.LineChart(
                                          _getSeriesData(),
                                          animate: true,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                ]))));
  }
}

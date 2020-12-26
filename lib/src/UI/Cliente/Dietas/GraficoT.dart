import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/datos/minutaCliente.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:loading_animations/loading_animations.dart';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/UI/Entrenador/listejercicios.dart';
import 'package:mvp_vandal/src/authscreen.dart';

import 'package:mvp_vandal/src/datos/minutaCliente.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/tipoDietas.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/DietasSelect.dart';

List<int> caloriasL = [0, 0, 0, 0, 0, 0, 0];
List<int> diasL = [1, 2, 3, 4, 5, 6, 7];
List<Grafico> lista = [];
int calo = 0;

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

  int dias = 1;

  final MinutaCliente datos =
      new MinutaCliente("", "", "", "", "", "", "", "", "", "", "");

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("dietasCliente");

    final List<String> listadias = [
      "Lunes",
      "Martes",
      "Miercoles",
      "Jueves",
      "Viernes",
      "Sabado",
      "Domingo"
    ];

    _getSeriesData() {
      List<charts.Series<Grafico, String>> series = [
        charts.Series(
            id: "calorias",
            data: lista,
            domainFn: (Grafico series, _) => series.dias.toString(),
            measureFn: (Grafico series, _) => series.calorias,
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
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 4,
            child: Scaffold(
                // termina barra drawer
                appBar: GradientAppBar(
                  title: Text('Calorias consumidas'),
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
                                    builder: (context) => TipoDietasCliente()));
                          }),
                      GestureDetector(
                          child: Tab(icon: Icon(Icons.calendar_today)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DietaSelect()));
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
                              if (Docs.data()["idCliente"] ==
                                  googleSignIn.currentUser.id) {
                                var dia = int.parse((Docs.data()["dia"]));
                                var calorias =
                                    int.parse(Docs.data()["calorias"]);
                                caloriasL[dia - 1] = calorias;
                                //lista.add(new Grafico(int.parse(Docs.data()["calorias"]), dia ));
                              }
                            }

                            for (var i = 0; i < 7; i++) {
                              calo = caloriasL[i] + calo;
                              lista.add(new Grafico(caloriasL[i], diasL[i]));
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
                                        "Calorias consumidas por Día",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      Expanded(
                                        child: charts.BarChart(
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

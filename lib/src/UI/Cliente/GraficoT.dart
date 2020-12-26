import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/DietasSelect.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/UI/Cliente/Metas.dart';
import 'package:mvp_vandal/src/UI/Entrenador/listejercicios.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/Metas.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/GraficoT.dart';

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
  int mes = cantmes;
  int kgactual = int.parse(peso);
  int kgmeta = int.parse(initialKg);
  int tiempometa = int.parse(initialTiempo);
  double calactualdia = double.parse(kcaldiarias);
  int totalcalactual = int.parse(totalkcalo);
  double indice = 0;
  double indice2 = 0;
  double progreso = 0;
  double ganado = 0;
  String accion = "";
  int kgdiff;
  int totalcalmeta;
  double caldiameta;

  final InfoEjercicio datos =
      new InfoEjercicio("", "", "", "", "", "", "", "", "", "", [], "", "");

  @override
  Widget build(BuildContext context) {
    kgdiff = kgmeta - kgactual;
    if (kgdiff >= 0) {
      accion = "subidos";
    } else {
      accion = "bajados";
    }
    totalcalmeta = (3600 * (kgdiff.abs()));
    caldiameta = totalcalmeta / (mes * 30);
    if (accion == "subidos") {
      indice = (((calo / 7.0) - calactualdia) / caldiameta) * 100;
      progreso = ((calo - totalcalactual) / totalcalmeta) * 100;
      ganado = (calo - totalcalactual) / 3600.0;
    } else {
      indice = ((calactualdia - (calo / 7.0)) / caldiameta) * 100;
      progreso = ((totalcalactual - calo) / totalcalmeta) * 100;
      ganado = (totalcalactual - calo) / 3600.0;
    }

    if (indice.abs() <= 100) {
      indice2 = indice;
    } else {
      indice2 = 100;
    }
    Query query = FirebaseFirestore.instance
        .collection("Resumen")
        .orderBy("id_incremental");
    Query query2 = FirebaseFirestore.instance.collection("Estadistica");

    _getSeriesDataSubir() {
      List<charts.Series<Grafico, String>> series = [
        charts.Series(
            id: "kcal",
            data: lista,
            domainFn: (Grafico series, _) => (series.dias + 1).toString(),
            measureFn: (Grafico series, _) =>
                (caloriasL[series.dias % 7] - series.kcal),
            colorFn: (Grafico series, _) =>
                charts.MaterialPalette.blue.shadeDefault)
      ];
      return series;
    }

    _getSeriesDataBajar() {
      List<charts.Series<Grafico, String>> series = [
        charts.Series(
            id: "kcal",
            data: lista,
            domainFn: (Grafico series, _) => (series.dias + 1).toString(),
            measureFn: (Grafico series, _) =>
                (series.kcal - caloriasL[series.dias % 7]),
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
            length: 6,
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
                          child: Tab(icon: Icon(Icons.flag)),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => MetasT()));
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
                              height: MediaQuery.of(context).size.height,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                      begin: Alignment.topRight,
                                      end: Alignment.bottomLeft,
                                      colors: [
                                    Colors.orange[900],
                                    Colors.amber
                                  ])),
                              padding: EdgeInsets.all(40),
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Column(
                                    children: <Widget>[
                                      Text(
                                        "Calorias ganadas/perdidas",
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      if (accion == "subidos")
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Expanded(
                                                child: charts.BarChart(
                                              _getSeriesDataSubir(),
                                              animate: true,
                                              domainAxis: charts.OrdinalAxisSpec(
                                                  renderSpec: charts
                                                      .SmallTickRendererSpec(
                                                          labelRotation: 60)),
                                            ))),
                                      if (accion == "bajados")
                                        Container(
                                            height: MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                3,
                                            width: MediaQuery.of(context)
                                                    .size
                                                    .width /
                                                2,
                                            child: Expanded(
                                                child: charts.BarChart(
                                              _getSeriesDataBajar(),
                                              animate: true,
                                              domainAxis: charts.OrdinalAxisSpec(
                                                  renderSpec: charts
                                                      .SmallTickRendererSpec(
                                                          labelRotation: 60)),
                                            ))),
                                      Container(
                                          margin: EdgeInsets.all(15),
                                          child: Row(children: <Widget>[
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircularPercentIndicator(
                                                        radius: 80.0,
                                                        lineWidth: 9.0,
                                                        animation: true,
                                                        percent: indice2 / 100,
                                                        center: new Text(
                                                          indice.toStringAsFixed(
                                                                  1) +
                                                              "%",
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.0),
                                                        ),
                                                        footer: new Text(
                                                          "Calorias",
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12.0),
                                                        ),
                                                        circularStrokeCap:
                                                            CircularStrokeCap
                                                                .round,
                                                        progressColor:
                                                            Colors.red[700],
                                                      )
                                                    ])),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircularPercentIndicator(
                                                        radius: 80.0,
                                                        lineWidth: 9.0,
                                                        animation: true,
                                                        percent: progreso / 100,
                                                        center: new Text(
                                                          progreso.toStringAsFixed(
                                                                  1) +
                                                              "%",
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.0),
                                                        ),
                                                        footer: new Text(
                                                          "Progreso",
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12.0),
                                                        ),
                                                        circularStrokeCap:
                                                            CircularStrokeCap
                                                                .round,
                                                        progressColor:
                                                            Colors.green[600],
                                                      )
                                                    ])),
                                            Container(
                                                margin: EdgeInsets.all(5),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      CircularPercentIndicator(
                                                        radius: 80.0,
                                                        lineWidth: 9.0,
                                                        animation: true,
                                                        percent: ganado / 100,
                                                        center: new Text(
                                                          ganado.toStringAsFixed(
                                                                  1) +
                                                              "KG",
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 14.0),
                                                        ),
                                                        footer: new Text(
                                                          "KG " + accion,
                                                          style: new TextStyle(
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              fontSize: 12.0),
                                                        ),
                                                        circularStrokeCap:
                                                            CircularStrokeCap
                                                                .round,
                                                        progressColor:
                                                            Colors.yellowAccent,
                                                      )
                                                    ])),
                                          ])),
                                      Container(
                                          child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              children: <Widget>[
                                            Text(
                                                "*Nota: Para conocer en mayor profundidad\n sobre su progreso, contacte\n a un especialista en el apartado\n de CONTACTO.")
                                          ]))
                                    ],
                                  ),
                                ),
                              ),
                            );
                          })),
                ]))));
  }
}

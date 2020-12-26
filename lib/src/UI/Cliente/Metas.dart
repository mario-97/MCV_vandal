import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/Entrenador/listejercicios.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:mvp_vandal/src/UI/Cliente/GraficoT.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';

String initialKg = "No asignado";
String initialTiempo = "No asignado";
int cantmes = 0;
String kcaldiarias;
String totalkcalo;

class Metas extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        //color de fondo de la vista
        brightness: Brightness.light,
        primaryColor: Colors.black,
        accentColor: Colors.orange[600],
      ),
      home: MetasT(),
    );
  }
}

class MetasT extends StatefulWidget {
  @override
  _MetasTState createState() => _MetasTState();
}

class _MetasTState extends State<MetasT> {
  final InfoEjercicio datos =
      new InfoEjercicio("", "", "", "", "", "", "", "", "", "", [], "", "");
  int _value = 1;
  int _value2 = 1;
  var meses = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12"];
  var kilos = ["50", "55", "60", "65", "70", "75", "80", "85", "90", "100"];

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("Estadistica");
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
                  title: Text("Definir metas"),
                  backgroundColorStart: Colors.orange[900],
                  backgroundColorEnd: Colors.orange,
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
                              Colors.amber[100],
                              Colors.amber[500],
                              Colors.amber[700],
                              Colors.amber[900]
                            ])),
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
                                              child:
                                                  CircularProgressIndicator());
                                        }
                                        if (stream.hasError) {
                                          return Center(
                                              child: Text(
                                                  stream.error.toString()));
                                        }
                                        QuerySnapshot querySnapshot =
                                            stream.data;
                                        for (var Docs in querySnapshot.docs) {
                                          initialKg = Docs.data()["kgobjetivo"];
                                          initialTiempo =
                                              Docs.data()["tiempoobjetivo"];
                                          totalkcalo = Docs.data()["totalk"];
                                          kcaldiarias =
                                              Docs.data()["kcalpromedio"];
                                        }
                                        return Container(
                                            child: Container(
                                                margin: EdgeInsets.all(30),
                                                child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    children: <Widget>[
                                                      Image(
                                                          image: new AssetImage(
                                                              'assets/images/metas.jpg'),
                                                          height: 200,
                                                          alignment:
                                                              Alignment.center),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Text(
                                                                    "Peso objetivo anterior: " +
                                                                        initialKg,
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)))
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Text(
                                                                    "Tiempo objetivo anterior: " +
                                                                        initialTiempo +
                                                                        "\n",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)))
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Text(
                                                                    "Nuevo peso objetivo",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)))
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  DropdownButton(
                                                                      value:
                                                                          _value2,
                                                                      isExpanded:
                                                                          true,
                                                                      style: new TextStyle(
                                                                          color: Colors.orange[
                                                                              900],
                                                                          fontWeight: FontWeight
                                                                              .w900),
                                                                      items: [
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("50 Kilos"),
                                                                          value:
                                                                              0,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("55 Kilos"),
                                                                          value:
                                                                              1,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("60 Kilos"),
                                                                            value: 2),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("65 Kilos"),
                                                                          value:
                                                                              3,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("70 Kilos"),
                                                                          value:
                                                                              4,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("75 Kilos"),
                                                                            value: 5),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("80 Kilos"),
                                                                          value:
                                                                              6,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("85 Kilos"),
                                                                          value:
                                                                              7,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("90 Kilos"),
                                                                            value: 8),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("100 Kilos"),
                                                                            value: 9),
                                                                      ],
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          _value2 =
                                                                              value;
                                                                        });
                                                                      }),
                                                            )
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                                child: Text(
                                                                    "Nuevo tiempo objetivo",
                                                                    style: TextStyle(
                                                                        color: Colors
                                                                            .white)))
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                              child:
                                                                  DropdownButton(
                                                                      value:
                                                                          _value,
                                                                      isExpanded:
                                                                          true,
                                                                      style: new TextStyle(
                                                                          color: Colors.orange[
                                                                              900],
                                                                          fontWeight: FontWeight
                                                                              .w900),
                                                                      items: [
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("1 mes"),
                                                                          value:
                                                                              0,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                          child:
                                                                              Text("2 meses"),
                                                                          value:
                                                                              1,
                                                                        ),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("3 meses"),
                                                                            value: 2),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("4 meses"),
                                                                            value: 3),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("5 meses"),
                                                                            value: 4),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("6 meses"),
                                                                            value: 5),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("7 meses"),
                                                                            value: 6),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("8 meses"),
                                                                            value: 7),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("9 meses"),
                                                                            value: 8),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("10 meses"),
                                                                            value: 9),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("11 meses"),
                                                                            value: 10),
                                                                        DropdownMenuItem(
                                                                            child:
                                                                                Text("12 meses"),
                                                                            value: 11),
                                                                      ],
                                                                      onChanged:
                                                                          (value) {
                                                                        setState(
                                                                            () {
                                                                          _value =
                                                                              value;
                                                                        });
                                                                      }),
                                                            )
                                                          ]),
                                                      Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: <Widget>[
                                                            Expanded(
                                                              flex: 20,
                                                              child:
                                                                  new RaisedButton(
                                                                      child:
                                                                          new Text(
                                                                        "Definir Metas",
                                                                        style: new TextStyle(
                                                                            color:
                                                                                Colors.white),
                                                                      ),
                                                                      color: Colors
                                                                              .orange[
                                                                          800],
                                                                      onPressed:
                                                                          () {
                                                                        cantmes =
                                                                            int.parse(meses[_value]);
                                                                        this.datos.operacion =
                                                                            "Metas";
                                                                        this.datos.kgobjetivo =
                                                                            kilos[_value2];
                                                                        this.datos.tiempoobjetivo =
                                                                            meses[_value];
                                                                        Navigator.push(
                                                                            context,
                                                                            MaterialPageRoute(builder: (context) => UserController(datos: this.datos)));
                                                                      }),
                                                            ),
                                                          ]),
                                                    ])));
                                      }))
                            ]))))));
  }
}

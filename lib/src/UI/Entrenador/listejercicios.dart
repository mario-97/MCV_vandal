import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/Entrenador/categorias/adelgazar.dart';
import 'package:mvp_vandal/src/UI/Entrenador/categorias/musculos.dart';
import 'package:mvp_vandal/src/UI/Entrenador/categorias/tonificar.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/UI/Cliente/GraficoT.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

class ListaEjercicio extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Ejercicios(),
    );
  }
}

class Ejercicios extends StatefulWidget {
  @override
  _EjerciciosState createState() => _EjerciciosState();
}

class _EjerciciosState extends State<Ejercicios> {
  String rol;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        debugShowCheckedModeBanner: false,
        home: DefaultTabController(
            length: 5,
            child: Scaffold(
                appBar: GradientAppBar(
                  title: Text("Categorias"),
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
                          Colors.orange,
                          Colors.orange[700],
                          Colors.orange[800],
                          Colors.orange[900]
                        ])),
                    child: Column(children: <Widget>[
                      Expanded(
                        flex: 1,
                        child: Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            margin: EdgeInsets.all(15),
                            elevation: 10,
                            child: Container(
                              height: MediaQuery.of(context).size.height / 3,
                              child: Column(children: <Widget>[
                                Image(
                                    image: new AssetImage(
                                        'assets/images/adelgazar.jpg')),
                                Expanded(
                                  flex: 1,
                                  child: ListTile(
                                      title: new Text(
                                          "Ejercicios para Perder peso",
                                          style: TextStyle(
                                              color: Colors.orange[700])),
                                      subtitle: Text(
                                          "Baja en Carbohidratos y grasas"),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => Uno()));
                                      }),
                                )
                              ]),
                            )),
                      ),
                      Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(children: <Widget>[
                                  Image(
                                      image: new AssetImage(
                                          'assets/images/tonificar.jpg')),
                                  Expanded(
                                    child: ListTile(
                                        title: new Text(
                                            "Ejercicios para Tonificar",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        subtitle: Text("Dieta equilibrada"),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Dos()));
                                        }),
                                  )
                                ]),
                              ))),
                      Expanded(
                          flex: 1,
                          child: Card(
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: EdgeInsets.all(15),
                              elevation: 10,
                              child: Container(
                                height: MediaQuery.of(context).size.height / 3,
                                child: Column(children: <Widget>[
                                  Image(
                                      image: new AssetImage(
                                          'assets/images/musculo.jpg')),
                                  Expanded(
                                    child: ListTile(
                                        title: new Text(
                                            "Ejercicios para Ganar masa muscular",
                                            style: TextStyle(
                                                color: Colors.orange[700])),
                                        subtitle:
                                            Text("Sobrecarga de proteinas"),
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Tres()));
                                        }),
                                  )
                                ]),
                              )))
                    ]),
                  ),
                ))));
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/Cliente/Controller.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/info.dart';

class UserEjercicio extends StatelessWidget {
  final InfoEjercicio datos;
  UserEjercicio({this.datos});
  int indice = 0;
  String idEjercicio;
  String idCliente = id;
  bool existe = false;
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("ListaEjercicio");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.cyan[600],
        ),
        initialRoute: '/ejercicios',
        routes: {
          '/controller': (context) => UserController(datos: this.datos),
        },
        home: DefaultTabController(
            length: 3,
            child: Scaffold(
                body: Center(
                    child: Container(
                        child: Column(children: <Widget>[
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
                          if (Docs.get("nombre") == this.datos.nombre) {
                            this.datos.idInfo = Docs.id;
                            existe = true;
                          } else {
                            this.datos.idInfo = this.datos.idInfo;
                            existe = true;
                          }
                        }
                        return Container(
                            decoration: BoxDecoration(
                                gradient: LinearGradient(
                                    begin: Alignment.topLeft,
                                    end: Alignment.bottomRight,
                                    colors: [
                                  const Color(0xFFFF9100),
                                  const Color(0xFF6D3100)
                                ])),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Card(
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: EdgeInsets.all(15),
                                    elevation: 5,
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: <Widget>[
                                          if (datos.operacion == "Ingresar")
                                            ListTile(
                                                title: new Text(
                                                    "\nSeguro deseas agregar a la rutina: "),
                                                subtitle: Text(datos.nombre +
                                                    "\nDuracion: " +
                                                    datos.tiempo +
                                                    "\nKcal total: " +
                                                    datos.kcal),
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/controller');
                                                }),

                                          //Image(
                                          //image: new AssetImage('assets/images/adelgazar.jpg')),

                                          if (datos.operacion == "Eliminar")
                                            ListTile(
                                                title: new Text(
                                                    "\nSeguro deseas Eliminar de la rutina: "),
                                                subtitle: Text(datos.nombre +
                                                    "\nDuracion: " +
                                                    datos.tiempo +
                                                    "\nKcal total: " +
                                                    datos.kcal),
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/controller');
                                                }),
                                          Text(
                                            'Presione para continuar... ',
                                            style: TextStyle(
                                                fontSize: 20.0,
                                                color: Colors.green[300],
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ]),
                                  ),
                                ]));
                      }))
            ]))))));
  }
  //if (datos.operacion == "Eliminar") {
  //Text(_id);
  //eliminar(_id);
  //Navigator.pop(context);
  //}
  //datos.idEjercicio = "hola1";

}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/entrenador/detalle.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/update.dart';
import 'package:mvp_vandal/src/datos/actividad.dart';
import 'package:mvp_vandal/src/datos/minuta.dart';


class DietaCliente extends StatelessWidget {
  final Minuta data;
  DietaCliente({this.data});

  

  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("dietas");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.dark,
          primaryColor: Colors.black,
          accentColor: Colors.cyan[600],
        ),
        initialRoute: '/updateDieta',
        home: Scaffold(
            appBar: new AppBar(
              title: new Text(
                "Detalle de la dieta: ",
                style: TextStyle(color: Colors.orange[900]),
              ),
              backgroundColor: Colors.black,
            ),
            body: Center(
                child: Container(
                    margin: new EdgeInsets.symmetric(horizontal: 30.0),
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
                                          child: CircularProgressIndicator());
                                    }
                                    if (stream.hasError) {
                                      return Center(
                                          child: Text(stream.error.toString()));
                                    }
                                    QuerySnapshot querySnapshot = stream.data;
                                    for (var Docs in querySnapshot.docs) {
                                      if (Docs.id == data.id) {

                                    Expanded( child: Column(children: <Widget>[
                                    
                                    //ARREGLAR ESTA WEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAaaaaa
                                    
                                    Card(
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(10)),
                                      margin: EdgeInsets.all(15),
                                      color: Colors.orangeAccent,
                                      elevation: 10,
                                      child: Column(children: <Widget>[
                                        ListTile(
                                            title: new Text("Tipo de dieta: ",style: new TextStyle(color: Colors.black87),textAlign: TextAlign.center), 
                                            subtitle: Docs.data()["tipodieta"],
                                            onTap: () {
                                            
                                            }),
                                      ]),
                                    ),
                                    ],
                                    ),
                                    );
                                    }
                                    }
                                    
                                  })
                    
                                  )
                        ])))));
  }
}

import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';
import 'package:mvp_vandal/src/UI/Cliente/Dietas/tipoDietas.dart';


class ErrorDia extends StatefulWidget {
  _ErrorDiaState createState() => _ErrorDiaState();
}

String rol;
String id;


class _ErrorDiaState extends State<ErrorDia> {
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
      home: Scaffold(
        appBar: GradientAppBar(
          title: Text("Error"),
          backgroundColorStart: Colors.orange[900],
          backgroundColorEnd: Colors.orange,
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
                              image: new AssetImage('assets/images/logo.png')),
                              
                          Expanded(
                            flex: 1,
                              child: Row(
                                    children: [
                                      Column(
                                        mainAxisSize: MainAxisSize.min,
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text("¡¡¡Dia ingresado incorrectamente!!!", style: TextStyle(
                                                        color: Colors.red,
                                                        fontSize: 30,
                                                        fontWeight: FontWeight.w500,
                                                        
                                                       ) ),
                                          Text(
                                              "El dia ya fue ingresado o fue ingresado erroneamente", style: Theme.of(context).textTheme.headline6),
                                              Text("Por favor vuelva atras", style: Theme.of(context).textTheme.headline6),
                                        ],
                                      ),
                                    ],
                                  ),
                          )
                        ]),
                      ))),
              
            ]),
          ),
        ),
      ),
    );
  }
}








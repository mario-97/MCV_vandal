import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/Suscripcion.dart';

class Contacto extends StatelessWidget {
  String title = "No cuenta con una suscripción";
  String content;

  TextStyle textStyle = TextStyle(color: Colors.black);

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
        child: AlertDialog(
          title: new Text(
            "Contenido Premium",
            style: textStyle,
          ),
          content: new Image(
              image: new AssetImage('assets/images/cara.png'),
              height: 120,
              alignment: Alignment.center),
          actions: <Widget>[
            new FlatButton(
              child: new Text("Suscribirme",
                  style: TextStyle(
                    color: Colors.orange[700],
                  )),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => Suscripcion()));
              },
            ),
            new FlatButton(
              child: Text("Cancelar",
                  style: TextStyle(
                    color: Colors.orange[700],
                  )),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => HomeScreen(
                            username: googleSignIn.currentUser.displayName)));
              },
            ),
          ],
        ));
  }
}

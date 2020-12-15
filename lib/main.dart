import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:mvp_vandal/src/splashscreen.dart';
import 'package:mvp_vandal/src/miapp.dart';
import 'package:mvp_vandal/src/UI/admin/registro.dart';
import 'package:mvp_vandal/src/UI/Entrenador/categorias/adelgazar.dart';

// Defining routes for navigation
var routes = <String, WidgetBuilder>{
  "/auth": (BuildContext context) => AuthScreen(),
  "/registro": (BuildContext context) => Registro(),
  "/adelgazar": (BuildContext context) => Uno(),
};

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    title: 'FaceBase',
    routes: routes,
    home: SplashScreen(),
  ));
}

import 'package:mvp_vandal/src/authscreen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mvp_vandal/src/miapp.dart';
import 'package:mvp_vandal/src/home.dart';
import 'package:mvp_vandal/src/UI/admin/registro.dart';
import 'package:mvp_vandal/src/UI/admin/listauser.dart';
import 'package:mvp_vandal/src/UI/entrenador/addrutina.dart';
import 'package:mvp_vandal/src/UI/entrenador/listejercicios.dart';
import 'package:mvp_vandal/src/UI/Cliente/Resumen.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/ingresarDieta.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/dietas.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/UI/Cliente/seleccionados.dart';
import 'package:mvp_vandal/src/UI/Cliente/GraficoT.dart';
import 'package:gradient_app_bar/gradient_app_bar.dart';

String rol;
String id;

class HomeScreen extends StatefulWidget {
  final String username;
  HomeScreen({Key key, @required this.username}) : super(key: key);
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  final _pages = [Home(), Home(), MiApp()];
  @override
  Widget build(BuildContext context) {
    Query query = FirebaseFirestore.instance.collection("usuarios");
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.black,
          accentColor: Colors.orange[600],
        ),
        initialRoute: '/homescreen',
        routes: {
          '/registro': (context) => Registro(),
          '/resumen': (context) => Resumen(),
        },
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            drawer: Drawer(
              // Barra lateral
              // Comienzo
              child: ListView(
                // Important: Remove any padding from the ListView.
                padding: EdgeInsets.zero,
                children: <Widget>[
                  DrawerHeader(
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
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
                                      if (Docs.get("mail") ==
                                          googleSignIn.currentUser.email) {
                                        rol = Docs.get("tipo");
                                        id = Docs.id;
                                      }
                                    }
                                    return Container();
                                  })),
                          Text('Configuraciones',
                              style: TextStyle(
                                color: Colors.white,
                              )),
                          Row(children: <Widget>[
                            Image.network(
                              googleSignIn.currentUser.photoUrl,
                              height: 50.0,
                              width: 50.0,
                            ),
                          ]),
                          Row(children: <Widget>[
                            Text(googleSignIn.currentUser.displayName,
                                style: TextStyle(
                                  color: Colors.white54,
                                )),
                          ]),
                          Row(children: <Widget>[
                            Text(googleSignIn.currentUser.email,
                                style: TextStyle(color: Colors.white30)),
                          ]),
                        ]),
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
                  ),
                  if (rol == "Administrador")
                    ListTile(
                      title: Text('Registrar usuario',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Registro()));
                      },
                    ),
                  if (rol == "Administrador")
                    ListTile(
                      title: Text('Ver usarios',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Lista()));
                      },
                    ),
                  if (rol == "Entrenador")
                    ListTile(
                      title: Text('Agregar ejercicio',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Rutina()));
                      },
                    ),
                  if (rol == "Entrenador" || rol == "Cliente")
                    ListTile(
                      title: Text('Lista de ejercicios',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Ejercicios()));
                      },
                    ),
                  if (rol == "Cliente")
                    ListTile(
                      title: Text('Mi Rutina',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Selecc()));
                      },
                    ),
                  if (rol == "Cliente")
                    ListTile(
                      title: Text('Mis estadisticas',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Resumen()));
                      },
                    ),
                  if (rol == "Cliente")
                    ListTile(
                      title: Text('Grafica',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => GraficoTT()));
                      },
                    ),
                  if (rol == "Nutricionista")
                    ListTile(
                      title: Text('Agregar dieta',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => IngresarDieta()));
                      },
                    ),
                  if (rol == "Nutricionista")
                    ListTile(
                      title: Text('Lista de Minutas',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => Dieta()));
                      },
                    ),
                  if (rol == "Cliente")
                    ListTile(
                      title: Text('Método de pago',
                          style: TextStyle(
                            color: Colors.orange[700],
                          )),
                      onTap: () {
                        // Update the state of the app
                        // ...
                        // Then close the drawer
                        Navigator.pop(context);
                      },
                    ),
                  ListTile(
                    title: Text('Cerrar Sesión',
                        style: TextStyle(
                          color: Colors.orange[700],
                        )),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      await googleSignIn.disconnect();
                      await googleSignIn.signOut();
                      Navigator.of(context).pushAndRemoveUntil(
                          MaterialPageRoute(builder: (context) => AuthScreen()),
                          (Route<dynamic> route) => false);
                    },
                  ),
                ],
              ),
            ),
            // termina barra drawer
            appBar: GradientAppBar(
              title: Text(widget.username),
              backgroundColorStart: Colors.orange[900],
              backgroundColorEnd: Colors.orange,
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.exit_to_app),
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    await googleSignIn.disconnect();
                    await googleSignIn.signOut();
                    Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => AuthScreen()),
                        (Route<dynamic> route) => false);
                  },
                ),
              ],
            ),
            body: _pages[_selectedIndex],
            bottomNavigationBar: new Theme(
              data: Theme.of(context).copyWith(
                canvasColor: Colors.orange[900],
                primaryColor: Colors.white,
              ),
              child: BottomNavigationBar(
                currentIndex: _selectedIndex,
                onTap: (int index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                }, // this will be set when a new tab is tapped
                items: [
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.home, color: Colors.white),
                    title: new Text('Inicio',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  ),
                  BottomNavigationBarItem(
                    icon: new Icon(Icons.mail, color: Colors.white),
                    title: new Text('Mensajes',
                        style: TextStyle(color: Colors.white)),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.person, color: Colors.white),
                    title: Text('Perfil',
                        style: TextStyle(
                          color: Colors.white,
                        )),
                  )
                ],
              ),
            )));
  }
}

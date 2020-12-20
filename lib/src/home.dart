import 'package:flutter/material.dart';
import 'package:mvp_vandal/src/UI/Nutricionista/home.dart';
import 'package:mvp_vandal/src/UI/entrenador/listejercicios.dart';

class Principal extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/registro',
      home: Home(),
    );
  }
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.dark,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
        ),
        initialRoute: '/home',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
            body: Scaffold(
                body: Center(
                    child: Container(
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
                Colors.amber,
                Colors.amber[900],
                Colors.orange,
                Colors.orange[700]
              ])),
          child: Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: GestureDetector(
                                      child: Container(
                                        child: Hero(
                                          tag: 'imageHero2',
                                          child: Image(
                                            image: AssetImage(
                                                'assets/images/principal.jpg'),
                                          ),
                                        ),
                                      ),
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Ejercicios()));
                                      }),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Text('Rutinas de ejercicios personalizadas',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      color: Colors.orange[900],
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Row(children: [
                              Expanded(
                                flex: 10,
                                child: GestureDetector(
                                    child: Container(
                                      child: Hero(
                                        tag: 'imageHero',
                                        child: Image(
                                          image: AssetImage(
                                              'assets/images/dieta.jpg'),
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  HomeNutri()));
                                    }),
                              )
                            ]),
                          ],
                        ),
                      ),
                      color: Colors.white,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 1,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Text('Dietas personalizadas',
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                      color: Colors.orange[900],
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    flex: 5,
                    child: Card(
                      child: Padding(
                        padding: const EdgeInsets.all(0),
                        child: Column(
                          children: [
                            Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: <Widget>[
                                  Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        Text('Nutricionista',
                                            style: TextStyle(
                                                color: Colors.orange[900])),
                                        Image(
                                          image: AssetImage(
                                              'assets/images/logonutri.png'),
                                          height: 80,
                                          alignment: Alignment.centerLeft,
                                        ),
                                      ]),
                                  Column(children: <Widget>[
                                    Text('Entrenador',
                                        style: TextStyle(
                                            color: Colors.orange[900])),
                                    Image(
                                      image: AssetImage(
                                          'assets/images/logoentrenador.png'),
                                      height: 80,
                                      alignment: Alignment.center,
                                    ),
                                  ]),
                                  Column(children: <Widget>[
                                    Text('Kinesiologo',
                                        style: TextStyle(
                                            color: Colors.orange[900])),
                                    Image(
                                      image: AssetImage(
                                          'assets/images/logokine.png'),
                                      height: 80,
                                      alignment: Alignment.center,
                                    ),
                                  ]),
                                ]),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                Text("PERSONAL ALTAMENTE CALIFICADO",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold)),
                              ],
                            ),
                          ],
                        ),
                      ),
                      color: Colors.white,
                      semanticContainer: true,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0),
                      ),
                      elevation: 5,
                      margin: EdgeInsets.all(5),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )))));
  }
}

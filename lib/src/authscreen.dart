import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

String name;
String email;
String imageUrl;
final FirebaseAuth auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  bool isVisible = false;
  Future<User> _signIn() async {
    await Firebase.initializeApp();
    final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
    final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication.idToken,
      accessToken: googleSignInAuthentication.accessToken,
    );
    // final AuthResult authResult = await auth.signInWithCredential(credential);
    // final User user = authResult.user;

    User user = (await auth.signInWithCredential(credential)).user;
    if (user != null) {
      name = user.displayName;
      email = user.email;
      imageUrl = user.photoURL;
    }
    return user;
  }

  @override
  Widget build(BuildContext context) {
    var swidth = MediaQuery.of(context).size.width;
    return MaterialApp(
        theme: ThemeData(
          //color de fondo de la vista
          brightness: Brightness.light,
          primaryColor: Colors.lightBlue[800],
          accentColor: Colors.cyan[600],
        ),
        initialRoute: '/auth',
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          body: Stack(
            children: <Widget>[
              new Image(
                  height: 400,
                  image: new AssetImage('assets/images/2.png'),
                  alignment: Alignment.center),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Visibility(
                    child: CircularProgressIndicator(
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Color(0xFFB2F2D52)),
                    ),
                    visible: isVisible,
                  )
                ],
              ),
              Container(
                margin: const EdgeInsets.only(
                  bottom: 60.0,
                ),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: SizedBox(
                    height: 54.0,
                    width: swidth / 1.45,
                    child: RaisedButton(
                        onPressed: () {
                          setState(() {
                            this.isVisible = true;
                          });
                          _signIn().whenComplete(() {
                            Navigator.of(context).pushAndRemoveUntil(
                                MaterialPageRoute(
                                    builder: (context) =>
                                        HomeScreen(username: name)),
                                (Route<dynamic> route) => false);
                          }).catchError((onError) {
                            Navigator.pushReplacementNamed(context, "/auth");
                          });
                        },
                        child: Text(
                          ' Continuar con Google',
                          style: TextStyle(fontSize: 16),
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: new BorderRadius.circular(30.0),
                        ),
                        elevation: 5,
                        color: Colors.orange[900]),
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}

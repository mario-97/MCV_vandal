import 'package:flutter/material.dart';
import 'package:credit_card/credit_card_form.dart';
import 'package:credit_card/credit_card_model.dart';
import 'package:credit_card/flutter_credit_card.dart';
import 'package:mvp_vandal/src/authscreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:mvp_vandal/src/homescreen.dart';
import 'package:mvp_vandal/src/UI/Cliente/Premium.dart';

class Suscripcion extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return SuscripcionT();
  }
}

class SuscripcionT extends State<Suscripcion> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;

  @override
  Widget build(BuildContext context) {
    void suscribir() async {
      await FirebaseFirestore.instance.collection("Ordenes").add({
        "CardNumber": cardNumber,
        "ExpiryDate": expiryDate,
        "CardHolderName": cardHolderName,
        "cvvCode": cvvCode,
        "estado": "Suscrito",
        "id_cliente": id,
      }).then((value) => print(value.id));

      await FirebaseFirestore.instance.collection("usuarios").doc(id).update({
        "estado": "Susscrito",
      }).then((_) {
        print("success!");
      });
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => Premium()));
    }

    return MaterialApp(
        title: 'Flutter Credit Card View Demo',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
          resizeToAvoidBottomInset: true,
          body: SafeArea(
            child: Column(children: <Widget>[
              CreditCardWidget(
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                height: 250,
                width: MediaQuery.of(context).size.width,
                animationDuration: Duration(milliseconds: 1000),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: CreditCardForm(
                    onCreditCardModelChange: onCreditCardModelChange,
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width / 2,
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Expanded(
                        flex: 20,
                        child: new RaisedButton(
                          child: new Text(
                            "Suscribir",
                            style: new TextStyle(color: Colors.white),
                          ),
                          color: Colors.orange[700],
                          onPressed: suscribir,
                        ),
                      ),
                    ]),
              )
            ]),
          ),
        ));
  }

  void onCreditCardModelChange(CreditCardModel creditCardModel) {
    setState(() {
      cardNumber = creditCardModel.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }
}

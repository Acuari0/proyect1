import 'package:biomagnapro/Paypal/PaypalWidget.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class NoMoney extends StatefulWidget{
  @override
  _NoMoneyState createState() => _NoMoneyState();
}

class _NoMoneyState extends State<NoMoney> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PrimaryColor(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){Navigator.pop(context);},
        ),
      ),
      body: makePayment(),
    );
  }
}
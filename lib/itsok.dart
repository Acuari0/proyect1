import 'package:biomagnapro/LoginWidget/LogFire.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
class  ItsOk extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: (RaisedButton(
          child: Text('melomamama'),
          onPressed:(){
            context.read<AuthService>().signOut();
          },
        )),
      ),
    );
  }
}

class  Load extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: (Center(
        child: Text('load'),
      )),
    );
  }
}

class  nope extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Scaffold(
        body: (RaisedButton(
          child: Text('nope'),
          onPressed:(){
            context.read<AuthService>().signOut();
          },
        )),
      ),
    );
  }
}
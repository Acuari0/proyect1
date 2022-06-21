import 'package:biomagnapro/Database/DatabaseFuntion.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:biomagnapro/Usages/Tiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';

class SelectT extends StatefulWidget{
  final BluetoothDevice server;

  const SelectT({this.server});
  @override
  _SelectTState createState() => _SelectTState();
}

class _SelectTState extends State<SelectT> {
  UserC userC=UserC("", " ", 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    DatabaseService.getUser().then((value) {
      setState(() {
        userC=value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor(),
          title: Text("Select The Treatment",
            style: TextStyle(
              fontSize:Size_Title(),
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              Navigator.pop(context) ;
            },
          ),


        ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fond.png"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Tiles(context, "Cocaine",widget.server,1,userC),
                SizedBox(height: 10,),
                Tiles(context, "Marijuana",widget.server,2,userC),
                SizedBox(height: 10,),
                Tiles(context, "Amphetamines",widget.server,3,userC),
                SizedBox(height: 10,),
                Tiles(context, "Analgesics",widget.server,4,userC),
                SizedBox(height: 10,),
                Tiles(context, "Alcohol",widget.server,5,userC),
                SizedBox(height: 10,),
                Tiles(context, "Tobacco",widget.server,6,userC),
                SizedBox(height: 10,),
                Tiles(context, "Food",widget.server,7,userC),
                SizedBox(height: 10,),
                Tiles(context, "Anxiolytics",widget.server,8,userC),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ],
      )
    );
  }
}
import 'package:biomagnapro/Database/DatabaseFuntion.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Info extends StatefulWidget {
  final UserC userC;
  Info(this.userC);
  @override
  _InfoState createState() => _InfoState();
}

class _InfoState extends State<Info> {

  var titles=["Cocaine","Marijuana","Amphetamines",
    "Analgesics","Alcohol","Tobacco","Food","Anxiolytics"];
  var Content;
  var Time;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body:
          ListView.builder(
          itemCount: 8,
          itemBuilder: (context,i){
            return new Column(
              children:[new ListTile(
                title: Column(
                  children:[
                    Container(height: 1,
                    color: PrimaryColor(),),
                    Container(

                      padding: EdgeInsets.all(3),
                      child: new Text(titles[i].toString(),
                      style: TextStyle(
                      fontSize: Size_Title()-8,
                      fontWeight: FontWeight.w300,
                          color: PrimaryColor()
                      ),),
                    ),
                    Container(height: 1,
                      color: PrimaryColor(),),
                    new Column(
                        children: [
                          Container(
                              padding: EdgeInsets.all(15),
                              child: Text(SetI(i),
                                style: TextStyle(
                                  fontSize:Size_Normal()-8,
                                  fontWeight: FontWeight.w300,

                                ),)
                          ),
                          Container(

                              padding: EdgeInsets.all(10),
                              child: Text("Number of sessions you have done:\t\t"+SetN(i),
                                style: TextStyle(
                                  fontSize:Size_Normal()-8,
                                  fontWeight: FontWeight.w300,
                                  color: PrimaryColor(),
                                ),)
                          ),
                          Container(

                              padding: EdgeInsets.all(10),
                              child: Text("Total Minutes in this program:\t\t"+SetS(i)+" min",
                                style: TextStyle(
                                  fontSize:Size_Normal()-8,
                                  fontWeight: FontWeight.w300,
                                  color: PrimaryColor(),
                                ),)
                          ),
                        ]
                    ),]
                ),
                //children: <Widget>[


              ),
              ]
            );
          },
        ),

    );
  }

  //Pinche perfeccionista
  String SetN(int i){
    if(i==0)
      return widget.userC.N1.toString();
    if(i==1)
      return widget.userC.N2.toString();
    if(i==2)
      return widget.userC.N3.toString();
    if(i==3)
      return widget.userC.N4.toString();
    if(i==4)
      return widget.userC.N5.toString();
    if(i==5)
      return widget.userC.N6.toString();
    if(i==6)
      return widget.userC.N7.toString();

    return widget.userC.N8.toString();
  }

  String SetS(int i){
    if(i==0)
      return widget.userC.S1.toString();
    if(i==1)
      return widget.userC.S2.toString();
    if(i==2)
      return widget.userC.S3.toString();
    if(i==3)
      return widget.userC.S4.toString();
    if(i==4)
      return widget.userC.S5.toString();
    if(i==5)
      return widget.userC.S6.toString();
    if(i==6)
      return widget.userC.S7.toString();

    return widget.userC.S8.toString();
  }

  String SetI(int i){
    if(i==0)
      return "This program help you to liadiate with the abstinence, effect of the consume of cocaine."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
    if(i==1)
      return "This program help you to liadiate with the abstinence, effect of the consume of marijuana."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
    if(i==2)
      return "This program help you to liadiate with the abstinence, effect of the consume of amphetamines."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
    if(i==3)
      return "This program help you to liadiate with the abstinence, effect of the consume of analgesics."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
    if(i==4)
      return "This program help you to liadiate with the abstinence, effect of the consume of alcohol."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
    if(i==5)
      return "This program help you to liadiate with the abstinence, effect of the consume of tobacco."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
    if(i==6)
      return "This program help you to liadiate with the abstinence, effect of the consume of food."
          "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";

    return "This program help you to liadiate with the abstinence, effect of the consume of Anxiolytics."
        "\n\nBiomagna Pro recommend do this program around 20-40 minutes per day";
  }
}

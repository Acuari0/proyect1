import 'package:biomagnapro/Bluetooth/DiscoveryPage.dart';
import 'package:biomagnapro/Bluetooth/NewFinder.dart';
import 'package:biomagnapro/Bluetooth/SelectBondedDevicePage.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:biomagnapro/Usages/BluetoothClass.dart';
import 'package:biomagnapro/Usages/Tiles.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ChangeTreat extends StatefulWidget{
  final UserC userC;
  //final BluetoothClass bluetoothDevice;
  ChangeTreat(this.userC,/*this.bluetoothDevice*/);
  @override
  _ChangeTreatState createState() => _ChangeTreatState();
}

class _ChangeTreatState extends State<ChangeTreat> {
  bool night=false,buzzer=false,auto_off=false;
  TextEditingController disp= new TextEditingController(text: "");
  getStateStepsister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      disp=new TextEditingController (text: (prefs.getString('disp') ?? "Biomagna Pro AE77"));
    });
  }
  setSteateStepsister() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('disp', disp.text.trim());
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      getStateStepsister();
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        onPressed: () async {
          /*final BluetoothDevice selectedDevice =
              await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return FindDevicesScreen(widget.bluetoothDevice);
              },
            ),
          );
          setState(() {
            disp=TextEditingController(text: selectedDevice.name);
            setSteateStepsister();
          });*/

        },
        child: Icon(Icons.bluetooth, color: Colors.blue,),
      ),
      body:Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fondo3.png"),
                    fit: BoxFit.cover
                )
            ),
          ),
          Column(children: [
            Column(
              children: [
                SizedBox(height: 10,),
                Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.all(10),
                    child: Text(
                      'Settings',
                      style: TextStyle(
                          color: Colors.white,

                          fontSize: 30,
                          letterSpacing: 2),
                    )),
                Container(width:100,child: Divider(color: Colors.white,thickness: 2,))
              ],
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Device settings",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),),
            ),
            Padding(padding:EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.white,height: 1,indent: 1,endIndent: 1,)),

            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Row(

                    children: [ Icon(Icons.bluetooth,color: Colors.white,),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Bluetooth dispositive",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),),
                      ),],
                  ),
                    Container(
                      width: 150,
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        style: TextStyle(
                            color: Colors.white,
                          fontSize: 10
                        ),
                        controller: disp,
                        onChanged: (text){

                        },
                        onSubmitted: (text){
                          if(text.isEmpty){
                            setState(() {
                              disp= TextEditingController (text:  "Biomagna Pro AE77");
                            });

                          }
                          else{
                            setState(() {
                              disp= TextEditingController (text:  text);
                            });
                          }


                          setSteateStepsister();
                        },

                        decoration: InputDecoration(
                          hintStyle: TextStyle(
                              color: Color.fromARGB(200, 126, 207, 215)
                          ),
                          labelStyle: TextStyle(
                              color: Color.fromARGB(200, 126, 207, 215)
                          ),
                          enabledBorder:  OutlineInputBorder(
                            borderSide:  BorderSide(color:Color.fromARGB(200, 126, 207, 215) , width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(40)),
                          ),
                          border: OutlineInputBorder(borderSide:  BorderSide(color:Color.fromARGB(200, 126, 207, 215) , width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(40)),),

                        ),
                      ),
                    ),

                  ],)
              ],),),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
            child: Column(children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [Row(

                children: [ Icon(Icons.brightness_low_outlined,color: Colors.white,),
                  Container(
                    padding: EdgeInsets.all(10),
                    child: Text("Light (night mode)",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:13,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),),
                  ),],
              ),
                  Switch(value: night, onChanged: (state){
                    setState(() {
                      night=state;
                    });
                  })

              ],)
            ],),),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Row(

                    children: [ Icon(Icons.volume_up,color: Colors.white,),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Buzzer",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),),
                      ),],
                  ),
                    Switch(value: buzzer, onChanged: (state){
                      setState(() {
                        buzzer=state;
                      });
                    })

                  ],)
              ],),),
            Padding(padding: EdgeInsets.symmetric(horizontal: 20),
              child: Column(children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [Row(

                    children: [ Icon(Icons.power_settings_new,color: Colors.white,),
                      Container(
                        padding: EdgeInsets.all(10),
                        child: Text("Auto OFF",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize:13,
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                          ),),
                      ),],
                  ),
                    Switch(value: auto_off, onChanged: (state){
                      setState(() {
                        auto_off=state;
                      });
                    })

                  ],)
              ],),),
            Container(
              padding: EdgeInsets.all(10),
              child: Text("Device Information",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),),
            ),
            Padding(padding:EdgeInsets.symmetric(horizontal: 10),
                child: Divider(
                  color: Colors.white,height: 1,indent: 1,endIndent: 1,)),
            Column(
              children: [
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Row(

                        children: [ Container(
                          height: 25,
                            width: 25,
                            child: Image.asset("assets/firmware.png")),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Firmware version",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),),
                          ),],
                      ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("1.0",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),),
                        ),

                      ],)
                  ],),),
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Row(

                        children: [ Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/label.png")),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Serial Number",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),),
                          ),],
                      ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("AA350657JJ",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),),
                        ),

                      ],)
                  ],),),
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Row(

                        children: [ Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/phone.png")),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("App version",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),),
                          ),],
                      ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("1.0",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),),
                        ),

                      ],)
                  ],),),
                SizedBox(height: 10,),
                Padding(padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Column(children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [Row(

                        children: [ Container(
                            height: 25,
                            width: 25,
                            child: Image.asset("assets/battery.png")),
                          Container(
                            padding: EdgeInsets.all(10),
                            child: Text("Battery",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:13,
                                fontWeight: FontWeight.w300,
                                color: Colors.white,
                              ),),
                          ),],
                      ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text("70%",
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize:13,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                            ),),
                        ),

                      ],)
                  ],),),
              ],
            )
          ],)
          /*Column(
            children: [
              Container(
                color: Colors.orange[100],
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Text("Note: The change of treatment have a cost of 1 credit",
                  style: TextStyle(
                    fontSize: Size_Normal()-5,
                    fontWeight: FontWeight.w300,
                    color: Colors.red[600],
                  ),),
              ),
              SizedBox(height: 30,),
              Tiles2(context, "Cocaine",1,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Marijuana",2,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Amphetamines",3,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Analgesics",4,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Alcohol",5,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Tobacco",6,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Food",7,widget.userC),
              SizedBox(height: 10,),
              Tiles2(context, "Anxiolytics",8,widget.userC),
              SizedBox(height: 10,),
            ],
          ),*/
        ],

      )
    );
  }
}
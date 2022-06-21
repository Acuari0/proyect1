import 'dart:async';
import 'dart:convert';
import 'dart:typed_data';
import 'package:biomagnapro/Bluetooth/BlueFuntions.dart';
import 'package:biomagnapro/Bluetooth/NewFinder.dart';
import 'package:biomagnapro/Bluetooth/Play.dart';
import 'package:biomagnapro/Menu/OnBluetooth/SelectT.dart';
import 'package:biomagnapro/Menu/help.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:biomagnapro/Usages/BluetoothClass.dart';
import 'package:biomagnapro/Usages/Tiles.dart';
import 'package:biomagnapro/onPlay.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:shared_preferences/shared_preferences.dart';




class Connect extends StatefulWidget{
   bool conected=false;
   final int treat;
   final String email;
   //final BluetoothClass bluetoothDevice;
   Connect({this.treat,this.email,/*this.bluetoothDevice*/});


  @override
  _ConnectState createState() => _ConnectState();
}

class _ConnectState extends State<Connect> {

  //BluetoothConnection connection;
  String status="CONNECT",address="";
  Stream<bool> stream;
  //BluetoothDevice bluetoothDevice;
  /*StreamSubscription<BluetoothDiscoveryResult> _streamSubscription;
  List<BluetoothDiscoveryResult> results = List<BluetoothDiscoveryResult>();*/
  bool isDiscovering;
  int index=-1;
  //FlutterBlue flutterBlue = FlutterBlue.instance;

  Future<bool> getData() async {
    return false;
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

     stream=new Stream.fromFuture(getData());

     setState(() {
       isDiscovering = true;

     });

  }
  getStateStepsister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      address = (prefs.getString('disp') ?? "Biomagna Pro AE77");


    });
  }

  @override
  Widget build(BuildContext context) {
    return  /*StreamBuilder(
      stream: stream,
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          return snapshot.data ? Treats() : No_Conected();
        });*/
    Control();

  }


  // ignore: non_constant_identifier_names
  Widget Control(){
    if(!widget.conected){
      return No_Conected();
    }
    return Treats();
  }


  Widget Tiles ( String title){
    return Container(

      width: MediaQuery.of(context).size.width-40,
      height: 50,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20.0),
      ),
      child: ListTile(
        title: Text(title,
          style: TextStyle(
            fontSize:Size_Title(),
            fontWeight: FontWeight.w300,
            color: PrimaryColor(),
          ),),
        leading: Icon(Icons.arrow_forward_ios,size: 30,color: PrimaryColor(),),
      ),
    );
  }

  // ignore: non_constant_identifier_names
  Widget Treats (){
    return Scaffold(
        appBar: AppBar(
          backgroundColor: PrimaryColor(),
          title: Text("Seleccione el Tratamiento",
            style: TextStyle(
              fontSize:Size_Title(),
              fontWeight: FontWeight.w300,
              color: Colors.white,
            ),),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: (){
              setState(() {
                widget.conected=false ;
              });

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
                  Tiles( "Cocaína"),
                  SizedBox(height: 10,),
                  Tiles( "Marihuana"),
                  SizedBox(height: 10,),
                  Tiles( "Anfetamínas"),
                  SizedBox(height: 10,),
                  Tiles("Analgésicos"),
                  SizedBox(height: 10,),
                  Tiles( "Alcohol"),
                  SizedBox(height: 10,),
                  Tiles( "Tabaco"),
                  SizedBox(height: 10,),
                  Tiles( "Comida"),
                  SizedBox(height: 10,),
                  Tiles( "Ansiolíticos"),
                  SizedBox(height: 10,),
                ],
              ),
            ),
          ],
        )
    );
  }
  void _restartDiscovery() {
    setState(() {

      //results.clear();
      isDiscovering = true;
    });

    _startDiscovery();
  }

  void _startDiscovery() {
    setState(() async {
      status="CONNECTING";



    });

    /* _streamSubscription =
        FlutterBluetoothSerial.instance.startDiscovery().listen((r) {
          setState(() {
            results.add(r);
          });
        });

    _streamSubscription.onDone(() {
      setState(() {
        isDiscovering = false;
      });
      setState(() {
        index=results.indexWhere((element) => element.device.name==address);
      });

      if(index>-1){
        setState(() {
          status="BEGIN";
        });


      }
      else{
        setState(() {
          status="TRY AGAIN";
        });

      }
    });*/
  }


  // ignore: non_constant_identifier_names
  Widget No_Conected(){
    return Scaffold(
      backgroundColor: Colors.white,
      extendBody: true,
      body: Stack(
        children: [

          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/fondo2.png"),
                    fit: BoxFit.cover
                )
            ),
          ),

          Container(
            child: Column(
              children: [
                Column(
                  children: [
                    SizedBox(height: 10,),
                    Container(
                        alignment: Alignment.center,
                        padding: EdgeInsets.all(10),
                        child: Text(
                          'Welcome',
                          style: TextStyle(
                              color: Colors.white,

                              fontSize: 30,
                          letterSpacing: 2),
                        )),
                    Container(width:100,child: Divider(color: Colors.white,thickness: 2,))
                  ],
                ),
                SizedBox(height: 130,),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 0,0, 0),
                  child: Container(
                    width: 200,

                    child: Text("Connect Biomagna pro to your mobile device",textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:15,
                        fontWeight: FontWeight.w300,
                        color: Colors.white,
                      ),),
                  ),
                ),
                SizedBox(height: 20,),
                /*Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 10),
                  child: Text("Empieza tu Sesiones ya !",
                    style: TextStyle(
                      fontSize:Size_Title(),
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),),
                ),*/
                /*Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.fromLTRB(0, 0, 00, 30),
                  child: Text("Connect Device to Bluetooth",
                    style: TextStyle(
                      fontSize:Size_Title(),
                      fontWeight: FontWeight.w300,
                      color: Colors.black,
                    ),),
                ),*/
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Container(
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: new BorderRadius.circular(50.0),

                    ),


                        child: FlatButton(
                          child: Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                            child: Text(status,
                              style: TextStyle(
                                fontSize:Size_Normal(),
                                fontWeight: FontWeight.w300,
                                color: PrimaryColor(),
                              ),),
                          ),
                          onPressed: ()  {

                            /*Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) {
                                  return FindDevicesScreen(widget.bluetoothDevice);
                                },
                              ),
                            );*/

                           /* if(status!="BEGIN" ){

                              if(status!="CONNECTING"){
                                if(status=="TRY AGAIN"){
                                  _restartDiscovery();
                                }
                                else{
                                  setState(() {
                                    getStateStepsister();
                                  });
                                  if (isDiscovering) {
                                    _startDiscovery();
                                  }
                                }
                              }


                            }
                            else{
                             /* Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      onPlay( results[index].device)));*/

                            }*/


                            setState(() {
                              //SystemSetting.goto(SettingTarget.BLUETOOTH);
                              //widget.conected=true;
                              //Funcionamineto de Antes
                              print(widget.email);
                              if(widget.email.isNotEmpty)
                                Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      MainPage(widget.treat)));
                              else
                                OK();
                            });
                        },

                    ),
                  ),
                ),
                SizedBox(height: 20,),
                FlatButton(
                  onPressed: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Help()));
                  },
                  child: Container(
                    width: 200,
                    alignment: Alignment.centerLeft,
                    margin: EdgeInsets.fromLTRB(40, 0, (MediaQuery.of(context).size.width/2), 0),
                    child: Text("Tap HERE for Help",textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize:15,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
  void OK() {

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(

            child:  Container(
              height: 160,
              width: 200,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Icon(Icons.info_outline,size: 40,color: SecondaryColor(),),
                  Text("No Internet Conexion, Please Restart",
                    style: TextStyle(
                        color: SecondaryColor(),
                        fontSize: 20
                    ),),
                  Container(
                    color: SecondaryColor(),
                    height: 50,
                    width: 150,
                    child: FlatButton(child:Text("Accept",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 20
                      ),) ,
                      onPressed: (){
                        Navigator.pop(context);
                      },),
                  )
                ],
              ),
            )
        );
      },
    );
  }
}

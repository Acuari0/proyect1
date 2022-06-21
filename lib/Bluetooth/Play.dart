import 'dart:async';
import 'dart:convert';
import 'dart:math';
import 'dart:typed_data';
import 'package:biomagnapro/Database/DatabaseFuntion.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/LoginWidget/LogFire.dart';
import 'package:biomagnapro/Menu/Menu.dart';
import 'package:biomagnapro/Paypal/PaypalTiles.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'package:provider/provider.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';


class PlayPage extends StatefulWidget{
  final BluetoothDevice server;
  final int i;

  const PlayPage({this.server,this.i});

  @override
  _PlayPageState createState() => _PlayPageState();
}

class _PlayPageState extends State<PlayPage> {
  UserC userC=UserC("", " ", 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0);
  BluetoothConnection connection;
  String hey="Espere un momento",battery="Connecting";

  bool isConnecting = false;
  bool Pay=true,playb=false;
  bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;
  Icon play = Icon(Icons.play_arrow, size: 30, color: PrimaryColor(),);

  final StopWatchTimer _stopWatchTimer = StopWatchTimer();




  //***************************************************************//
  Widget TeHasBajadoDeLaMula() => Pay ? Ok(): NotPay();

  void _open() {

  }

  void _playPause() {
    setState(() {
      if(playb) {
        play = Icon(Icons.play_arrow, size: 30, color: PrimaryColor(),);
        _sendMessage("%");
        _stopWatchTimer.onExecute.add(StopWatchExecute.stop);

        playb=false;
      }
      else {
        play = Icon(Icons.pause, size: 30,color: PrimaryColor());
        _sendMessage("#<?<KKKQNMPPUW[RKY*");
        _stopWatchTimer.onExecute.add(StopWatchExecute.start);
        playb=true;
      }

    });
  }

  void _onDataReceived(Uint8List data) {
    // Allocate buffer for parsed data
    int backspacesCounter = 0;
    data.forEach((byte) {
      if (byte == 8 || byte == 127) {
        backspacesCounter++;
      }
    });
    Uint8List buffer = Uint8List(data.length - backspacesCounter);
    int bufferIndex = buffer.length;

    // Apply backspace control character
    backspacesCounter = 0;
    for (int i = data.length - 1; i >= 0; i--) {
      if (data[i] == 8 || data[i] == 127) {
        backspacesCounter++;
      } else {
        if (backspacesCounter > 0) {
          backspacesCounter--;
        } else {
          buffer[--bufferIndex] = data[i];
        }
      }
    }

    // Create message if there is new line character
    String dataString = String.fromCharCodes(buffer);
    int index = buffer.indexOf(13);
    setState(() {
      if(dataString.contains("9")){
        battery="100%";
      }
      if(dataString.contains("8")){
        battery="90%";
      }
      if(dataString.contains("7")){
        battery="80%";
      }
      if(dataString.contains("6")){
        battery="70%";
      }
      if(dataString.contains("5")){
        battery="60%";
      }
      if(dataString.contains("4")){
        battery="50%";
      }
      if(dataString.contains("3")){
        battery="40%";
      }
      if(dataString.contains("2")){
        battery="30%";
      }
      if(dataString.contains("1")){
        battery="20%";
      }
      if(dataString.contains("0")){
        battery="10%";
      }

    });

  }
  Future<void> Iniciar() async {
    BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
      });
      setState(() {
        hey="se ha conectado";
        isConnecting=true;

      });

      connection.input.listen(_onDataReceived).onDone(() {

        if (isDisconnecting) {
          print('Disconnecting locally!');
        } else {
          print('Disconnected remotely!');
        }
        if (this.mounted) {
          setState(() {});
        }
      });
    }).catchError((error) {
      print('Cannot connect, exception occured');
      print(error);
    });
    /*try{
      connection = await BluetoothConnection.toAddress(widget.server.address);
      setState(() {

        hey="se ha conectado";
        isConnecting=true;
        if(isConnecting){
          _sendMessage("!");
          connection.input.last.then((value) {
            setState(() {
              battery=ascii.decode(value);
            });
          });
        }

      });

    }
    catch (exception) {
      setState(() {
        print('Cannot connect, exception occured');
        hey="no se ha podido conectar\$";
        isConnecting=false;
      });

    }*/
  }

  @override
  void initState()  {
    // TODO: implement initState
    super.initState();
    _open();
    //_sendMessage("I");

    setState(() {
      DatabaseService.getUser().then((value) {
        setState(() {
          userC=value;
        });
      });
      Iniciar();
      Future.delayed(Duration(seconds: 3),(){
        if(isConnecting)
          _sendMessage("!");
      });

    });

    /*setState(() {
      BluetoothConnection.toAddress(widget.server.address).then((_connection) {
        print('Connected to the device');
        connection = _connection;
        setState(() {
          isConnecting = false;
          isDisconnecting = false;
        });

        connection.input.listen(_onDataReceived).onDone(() {
          if (isDisconnecting) {
            print('Disconnecting locally!');
          } else {
            print('Disconnected remotely!');
          }
          if (this.mounted) {
            setState(() {});
          }
        });


      }).catchError((error) {
        print('Cannot connect, exception occured');
        print(error);

      });
    });*/

  }
  String Message=" ";

  bool load=false;



  @override
  void dispose() async {
    await _stopWatchTimer.dispose();
    // Avoid memory leak (`setState` after dispose) and disconnect
    if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    setState(() {
      _sendMessage("\$");
      if(isConnecting)
        connection.finish();
    });
    if(isConnecting)
      connection.finish();
    super.dispose();
  }

  void OK() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(

            child:  Container(
              height: 180,
              width: 120,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Icon(Icons.info_outline,size: 40,color: SecondaryColor(),),
                  Text("Are you sure that you want to pay 1 credit?",
                    style: TextStyle(
                        color: SecondaryColor(),
                      fontSize:Size_Normal(),
                      fontWeight: FontWeight.w300,
                    ),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: SecondaryColor(),
                            borderRadius: new BorderRadius.circular(50.0),

                        ),
                        child: FlatButton(child:Text("Yes",
                          style: TextStyle(
                              color: Colors.white,
                            fontSize:Size_Normal(),
                            fontWeight: FontWeight.w300,

                          ),) ,
                          onPressed: (){
                            if (userC.credits > 0) {
                              setState(() {
                                userC.credits--;
                              });
                              Map<String, dynamic> childrenPathValueMap = {};
                              print(userC.key);
                              childrenPathValueMap['users/' + userC.key + '/Creditos'] =
                                  userC.credits;
                              childrenPathValueMap['users/' + userC.key + '/N'+userC.treat.toString()] =
                                  NumberS()+1;
                              FirebaseDatabase.instance.reference().update(
                                  childrenPathValueMap);

                              Pay = true;
                              _playPause();
                              Navigator.pop(context);
                            }
                            else{
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      NoMoney()));
                            }


                          },),
                      ),
                      SizedBox(width: 20,),
                      Container(

                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: new BorderRadius.circular(50.0),

                        ),
                        child: FlatButton(child:Text("No",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:Size_Normal(),
                            fontWeight: FontWeight.w300,

                          ),) ,
                          onPressed: (){

                            Navigator.pop(context);

                          },),
                      )
                    ],
                  ),
                ],
              ),
            )
        );
      },
    );
  }

  int TypeSesion(){
    if(userC.treat==1)
      return userC.S1;
    if(userC.treat==2)
      return userC.S2;
    if(userC.treat==3)
      return userC.S3;
    if(userC.treat==4)
      return userC.S4;
    if(userC.treat==5)
      return userC.S5;
    if(userC.treat==6)
      return userC.S6;
    if(userC.treat==7)
      return userC.S7;

    return userC.S8;
  }
  int NumberS(){
    if(userC.treat==1)
      return userC.N1;
    if(userC.treat==2)
      return userC.N2;
    if(userC.treat==3)
      return userC.N3;
    if(userC.treat==4)
      return userC.N4;
    if(userC.treat==5)
      return userC.N5;
    if(userC.treat==6)
      return userC.N6;
    if(userC.treat==7)
      return userC.N7;

    return userC.N8;
  }
  void OK2() {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(

            child:  Container(
              height: 180,
              width: 120,
              padding: EdgeInsets.all(10),
              child: Column(
                children: [
                  Icon(Icons.info_outline,size: 40,color: SecondaryColor(),),
                  Text("Are you sure that you want to end the session?",
                    style: TextStyle(
                      color: SecondaryColor(),
                      fontSize:Size_Normal(),
                      fontWeight: FontWeight.w300,
                    ),),
                  SizedBox(height: 20,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(

                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: SecondaryColor(),
                          borderRadius: new BorderRadius.circular(50.0),

                        ),
                        child: FlatButton(child:Text("Yes",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:Size_Normal(),
                            fontWeight: FontWeight.w300,

                          ),) ,
                          onPressed: (){
                            _sendMessage("\$");
                            if(isConnecting)
                              connection.finish();
                            if(Pay){
                              dispose();
                              Map<String, dynamic> childrenPathValueMap = {};
                              print(minutes);
                              childrenPathValueMap['users/' + userC.key + '/S'+userC.treat.toString()] =
                                  int.parse(minutes)+TypeSesion();
                              FirebaseDatabase.instance.reference().update(
                                  childrenPathValueMap);
                              Navigator.of(context).popUntil(ModalRoute.withName('/'));
                              Navigator.push(context,
                                  MaterialPageRoute(builder: (context) =>
                                      Menu()));
                            }
                            else{
                              Navigator.pop(context);
                              Navigator.pop(context);
                            }
                          },),
                      ),
                      SizedBox(width: 20,),
                      Container(

                        height: 50,
                        width: 100,
                        decoration: BoxDecoration(
                          color: Colors.red,
                          borderRadius: new BorderRadius.circular(50.0),

                        ),
                        child: FlatButton(child:Text("No",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize:Size_Normal(),
                            fontWeight: FontWeight.w300,

                          ),) ,
                          onPressed: (){

                            Navigator.pop(context);

                          },),
                      )
                    ],
                  ),
                ],
              ),
            )
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: PrimaryColor(),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          color: Colors.white,
          onPressed: (){OK2();
          setState(() {

          });
          },
        ),
        actions: [
          Row(
            children: [
              Text(/*"Credits: "+userC.credits.toString()+" "*/"",
                style: TextStyle(
                  fontSize:Size_Normal(),
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),),
              //Icon(Icons.monetization_on,size: 20,color: Colors.white,),
              SizedBox(width: 10,)
            ],
          )
        ],
      ),
      bottomNavigationBar: Container(

        decoration: BoxDecoration(
            color: PrimaryColor(),

            border: Border.all(
                color: SecondaryColor(),
                width: 2.5
            )
        ),
        child: FlatButton(
          padding: EdgeInsets.symmetric(vertical: 15),

            splashColor: SecondaryColor(),
            onPressed: (){
            if(!Pay) {
              OK();
            }
            else{
              _playPause();
              print(playb);
            }

            },

          child: Container (
            child: play,
            width: 50,
            height: 50,
            padding: EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: new BorderRadius.circular(50.0),
              border: Border.all(
                color: SecondaryColor(),
                width: 2.5
              )
            ),
          )
        ),
      ),

      body: Ok()//TeHasBajadoDeLaMula()
    );
     /*RaisedButton(child: Text('enviar'),
    onPressed: (){_sendMessage("wawanagua firsy");
    _playPause();},);*/
  }
  String minutes=" ", seconds=" ";


//ESTTO
  Widget Ok(){
    return StreamBuilder<int>(
      stream: _stopWatchTimer.secondTime,
      initialData: 0,
      builder: (context, snap) {
        final value = snap.data;
        if(value>59){
          minutes=((value/60).toInt()).toString();
          seconds=(value-(int.parse(minutes)*60)).toString();
        }
        else{
          seconds=value.toString();
          minutes="0";
        }
        if(int.parse(minutes)<10)
          minutes="0"+minutes;
        if(int.parse(seconds)<10)
          seconds="0"+seconds;
        if(seconds=="59"){
          print("HE aqui un error");
          _sendMessage("!");

        }
       // print('Listen every minute. $value');
        if(int.parse(minutes)==57&&int.parse(seconds)==20){
          dispose();
          Map<String, dynamic> childrenPathValueMap = {};
          print(userC.key);
          childrenPathValueMap['users/' + userC.key + '/S'+userC.treat.toString()] =
              int.parse(minutes)+TypeSesion();
          FirebaseDatabase.instance.reference().update(
              childrenPathValueMap);
          Navigator.of(context).popUntil(ModalRoute.withName('/'));
          Navigator.push(context,
              MaterialPageRoute(builder: (context) =>
                  Menu()));
          //Aqui
        }

        return Column(
          children: <Widget>[
          Container(
          alignment: Alignment.center,
            padding: EdgeInsets.fromLTRB(0, 15, 0, 15),
            child: Text(/*selectName()*/"Treatment",
              style: TextStyle(
                fontSize: Size_Title(),
                fontWeight: FontWeight.w400,
                color: ThirdColor(),
              ),),
          ),
            Padding(
                padding: const EdgeInsets.all(0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    AnimatedContainer(
                      height: 100,
                      width: MediaQuery.of(context).size.width,
                      alignment: Alignment.center,
                      duration: Duration(seconds:2),
                      // Provide an optional curve to make the animation feel smoother.
                      curve: Curves.fastOutSlowIn,
                      decoration: BoxDecoration(
                          color: PrimaryColor(),

                          border: Border.all(
                              color: SecondaryColor(),
                              width: 3.5
                          )
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 4),
                            child: Text(
                              minutes+" : "+seconds,
                              style: TextStyle(
                              fontSize:50,
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                               )
                            ),
                          ),
                          Text("Time of Session",style: TextStyle(
                              fontSize: Size_Normal(),
                              fontWeight: FontWeight.w300,
                              color: Colors.white,
                              height: 2,
                              wordSpacing: 2
                          ),)
                        ]
                      ),
                    ),

                  ],
                )
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(5),

              child: Text("Battery: $battery",
                  style: TextStyle(
                      fontSize: Size_Normal(),
                      fontWeight: FontWeight.w700,
                      color: SecondaryColor(),
                      height: 2,
                      wordSpacing: 2
                  )),
            ),
            Container(
              alignment: Alignment.center,
              padding: EdgeInsets.all(25),

              child: Text("This program will take 57 min and 20 sec, ",
                  style: TextStyle(
                      fontSize: Size_Normal(),
                      fontWeight: FontWeight.w300,
                      color: SecondaryColor(),
                      height: 2,
                      wordSpacing: 2
                  )),
            ),
            FlatButton(
              onPressed: (){
                OK2();
                setState(() {

                });

              },
              child: Container (
                alignment: Alignment.center,
                child:Text("End Sesion",
                  style: TextStyle(
                  fontSize: Size_Normal(),
                  fontWeight: FontWeight.w300,
                  color: Colors.red,
                  wordSpacing: 2
                  )) ,
                width: 150,
                height: 50,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(50.0),
                    border: Border.all(
                        color: Colors.red,
                        width: 2.5
                    )
                ),
              ),

            ),
            StreamBuilder(
                stream: Stream.periodic(Duration(minutes: 1)),
                builder: (context, snap){

                          if(isConnecting && !playb){
                            Future.delayed(Duration(minutes: 1),(){
                            _sendMessage("!");
                            print("periodic");
                            });


                          }
                      return SizedBox();
                    }),
                    SizedBox(height: 20,),
                    /*Text(hey,style: TextStyle(
                      fontSize: 25
                    ),),*/
          ],
        );
      },
    );
  }

  String selectName(){
    if(widget.i==1){
      return "Cocaine";
    }
    if(widget.i==2){
      return "Marijuana";
    }
    if(widget.i==3){
      return "Amphetamines";
    }
    if(widget.i==4){
      return "Analgesics";
    }
    if(widget.i==5){
      return "Alcohol";
    }
    if(widget.i==6){
      return "Tobacco";
    }
    if(widget.i==7){
      return "Food";
    }
    return "Anxiolytics";
  }

  Widget NotPay(){
    return Center(
      child: Column(

        children: [
          SizedBox(
            height: 15,
          ),
          Container(

            height: 230,
            width: MediaQuery.of(context).size.width,
            child: Image.asset("assets/aux1.png"),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(20),

            child: Text("You have selected the program "+
                selectName()+
                ".\nThis program have a cost of 1 credit "
                "\nAnd will be end in 40 min.\n\n"
                "To start this treatment press the Play button.",
                style: TextStyle(
                    fontSize: Size_Normal(),
                    fontWeight: FontWeight.w300,
                    color: SecondaryColor(),
                    height: 2,
                    wordSpacing: 2
                )),
          ),
          Container(
            alignment: Alignment.center,
            padding: EdgeInsets.all(5),

            child: Text("Have a nice session!",
                style: TextStyle(
                    fontSize: Size_Normal()+15,
                    fontWeight: FontWeight.w200,
                    color: SecondaryColor(),
                    height: 2,
                    wordSpacing: 2
                )),
          ),


        ],
      ),
    );
  }

  void _sendMessage(String text) async {

    text = text+"\r\n";
    if(true){
      print("ENviando... $text");
      if (text.length > 0) {
        try {
          connection.output.add(utf8.encode(text));
          await connection.output.allSent;
          print(text);
          hey="Enviado comando $text";

        } catch (e) {
          print("aaaaaaaaaaaaaa");
          hey="no se ha enviado nada";
          //Iniciar();// Ignore error, but notify state

        }
      }

    }


  }

}




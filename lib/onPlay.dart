import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
//import 'package:flutter_blue/flutter_blue.dart';
import 'package:meta/meta.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:stop_watch_timer/stop_watch_timer.dart';

class onPlay extends StatefulWidget{
  //final  BluetoothDevice server;
  const onPlay(/*this.server*/);
  @override
  _onPlayState createState() => _onPlayState();
}

class _onPlayState extends State<onPlay> {
  //BluetoothConnection connection;
  bool isConnecting = true,end=false,end2=false;
  bool Pay=false,playb=false;
 // bool get isConnected => connection != null && connection.isConnected;

  bool isDisconnecting = false;
  final StopWatchTimer _stopWatchTimer = StopWatchTimer();
  String minutes=" ", seconds=" ";

  /*void _sendMessage(String text) async {
    text = text.trim();
    if (text.length > 0) {
      try {
        connection.output.add(utf8.encode(text));
        await connection.output.allSent;

      } catch (e) {
        print("aaaaaaaaaaaaaa");        // Ignore error, but notify state
        setState(() {});
      }
    }
  }
  Future send(Uint8List data) async {
    connection.output.add(data);
    await connection.output.allSent;
  }*/
  void _playPause() {
    setState(() {
      if(playb) {
        Future.delayed(Duration(milliseconds: 1),
                () async {
              /*List<BluetoothService> services = await widget.server.discoverServices();
              services.forEach((service) async {
                // do something with service
                var characteristics = service.characteristics;
                for(BluetoothCharacteristic c in characteristics) {
                  List<int> value = await c.write(utf8.encode('%'));
                  print(value);
                }
// Writes to a characteristic
              });*/
            });
        /*
        _sendMessage("%");
        send(utf8.encode("%"));*/

        if(!end)
          _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
        playb=false;
      }
      else {
        print("play");
        Future.delayed(Duration(milliseconds: 1),
                () async {
              /*List<BluetoothService> services = await widget.server.discoverServices();
              services.forEach((service) async {
                // do something with service
                var characteristics = service.characteristics;
                for(BluetoothCharacteristic c in characteristics) {
                  List<int> value = await c.write(utf8.encode('##&#22285477<>B99*'));
                  print(value);
                }
// Writes to a characteristic
              });*/
            });
       /* _sendMessage('#');
        send(utf8.encode('#'));
        _sendMessage("##&#22285477<>B99*");
        send(utf8.encode("##&#22285477<>B99*"));*/
        if(!end)
          _stopWatchTimer.onExecute.add(StopWatchExecute.start);
        playb=true;
      }

    });
  }

  /*connect(String address) async {
    try {
      connection = await BluetoothConnection.toAddress(address);
      print('Connected to the device');

      connection.input.listen((Uint8List data) {
        //Data entry point
        print(ascii.decode(data));
      });

    } catch (exception) {
      print('Cannot connect, exception occured');
    }
  }*/
  


  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Future.delayed(Duration(milliseconds: 1),
        () async {
          /*List<BluetoothService> services = await widget.server.discoverServices();
          services.forEach((service) async {
            // do something with service
            var characteristics = service.characteristics;
            for(BluetoothCharacteristic c in characteristics) {
              List<int> value = await c.write(utf8.encode('#'));
              print(value);
            }
// Writes to a characteristic
          });*/
        });




   /* BluetoothConnection.toAddress(widget.server.address).then((_connection) {
      print('Connected to the device');
      connection = _connection;
      setState(() {
        isConnecting = false;
        isDisconnecting = false;
        _sendMessage('#');
        send(utf8.encode('#'));
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

    });*/
    /*Future.delayed(Duration(milliseconds: 100),() async {

      await connect(widget.server.address);
    }).then((value) {
      _sendMessage('#');
      send(utf8.encode('#'));
    });*/
  }
  @override
  void dispose() async {
    await _stopWatchTimer.dispose();
    Future.delayed(Duration(milliseconds: 1),
            () async {
          /*List<BluetoothService> services = await widget.server.discoverServices();
          services.forEach((service) async {
            // do something with service
            var characteristics = service.characteristics;
            for(BluetoothCharacteristic c in characteristics) {
              List<int> value = await c.write(utf8.encode(String.fromCharCode(0x24).trim()));
              print(value);
            }
// Writes to a characteristic
          });*/
        });
    //await widget.server.disconnect();

    // Avoid memory leak (`setState` after dispose) and disconnect
   /* if (isConnected) {
      isDisconnecting = true;
      connection.dispose();
      connection = null;
    }
    _sendMessage(String.fromCharCode(0x24).trim());
    send(utf8.encode(String.fromCharCode(0x24).trim()));*/

    super.dispose();
  }
  void CallDialog(){
    _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
    DialogBack();

  }

  void DialogBack(){
    showDialog(context: context,
        barrierDismissible: false,
        builder: ( BuildContext context){
      return WillPopScope(
        onWillPop: () async => false,
        child: Dialog(
          child: Container(
            height: 200,
            width: 300,
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Session completed",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:15,
                      fontWeight: FontWeight.w500,
                      color: Color.fromARGB(250,30, 120,167),
                    ),),
                ),
                Container(
                  padding: EdgeInsets.all(10),
                  child: Text("Now it's time to keep moving.\nSee you in the next session!",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:15,
                      fontWeight: FontWeight.w200,
                      color: Color.fromARGB(250,30, 120,167),
                    ),),
                ),
                Container(

                  decoration: BoxDecoration(
                      border: Border.all(
                        color: Color.fromARGB(250,30, 120,167), //                   <--- border color
                        width: 3.0,
                      ),
                      borderRadius: BorderRadius.all(
                          Radius.circular(60.0))
                  ),
                  child: FlatButton(child: Text("39 Sessions Remaining",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize:15,
                      fontWeight: FontWeight.w200,
                      color: Color.fromARGB(250,30, 120,167),
                    ),),
                  onPressed: (){

                    Navigator.pop(context);
                    setState(() {
                      end2=true;
                    });

                  },),
                )
              ],
            ),
          ),
        ),
      );
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
  }
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(208, 20,56, 100),
          leading: IconButton(
            icon: Icon(Icons.arrow_back),
            color: Colors.white,
            onPressed: () async {Navigator.pop(context);
            //await widget.server.disconnect();
            },
          ),
          actions: [
            Row(
              children: [
                Text("Sessions: "+"40",
                  style: TextStyle(
                    fontSize:10,
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),),

                SizedBox(width: 10,)
              ],
            )
          ],
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/fondo3.png"),
                      fit: BoxFit.cover
                  )
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                      child: Image.asset("assets/logoblanco.png"),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(10),
                      child: Text("Quit Smoking treatment selected",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),),
                    ),
                    SizedBox(height: 50,),
                    StreamBuilder<int>(
                      stream: _stopWatchTimer.secondTime,
                      initialData: 0,
                        builder: (context, snap){
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
                          print('Listen every minute. $value');
                          if(int.parse(minutes)==40){
                            end=true;
                            Future.delayed(Duration.zero, () async {
                              CallDialog();
                            });


                           // _stopWatchTimer.onExecute.add(StopWatchExecute.stop);
                           // DialogBack();
                          }
                          if(end2){
                            Navigator.pop(context);
                            dispose();
                          }
                          return Stack(
                            alignment: Alignment.center,
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width,

                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.white, //                   <--- border color
                                width: 5.0,
                              ),
                              borderRadius: BorderRadius.all(
                              Radius.circular(60.0))
                            ),
                            child: LinearPercentIndicator(
                              padding: EdgeInsets.symmetric(horizontal: 30),

                              width: MediaQuery.of(context).size.width-50,
                              lineHeight:60,
                              backgroundColor: Colors.transparent,
                              percent: (value/(60*40)<1)?(value/(60*40)):1,
                              progressColor: Colors.white,
                            ),),
                              Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                      child: Text((value>0)?
                                          minutes+" : "+seconds:"Treatment lenght: 40min",
                                          style: TextStyle(
                                            fontSize:(value>0)?30:20,
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(250,30, 120,167),
                                          )
                                      ),
                                    ),

                                  ]
                              ),
                            ],
                          );
                        }
                    ),
                    SizedBox(height: 50,),
                    Container(
                      height: 130,
                      width: 130,
                      child: FlatButton(
                        onPressed: (){
                          _playPause();

                        },
                          child: Image.asset(!playb?"assets/play.png":"assets/pause.png")),
                    ),
                    SizedBox(height: 50,),
                    Container(
                      padding: EdgeInsets.all(0),
                      child: Text("Need more information about this treatment? ",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize:15,
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                        ),),
                    ),
                    Container(

                      child: FlatButton(
                          onPressed: (){

                          },
                          child: Container(
                            padding: EdgeInsets.all(0),
                            child: Text("Tap here",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize:15,
                                fontWeight: FontWeight.w500,
                                color: Colors.white,
                              ),),
                          ),),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
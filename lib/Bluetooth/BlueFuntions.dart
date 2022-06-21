import 'dart:async';
import 'package:biomagnapro/Bluetooth/Play.dart';
import 'package:biomagnapro/Database/DatabaseFuntion.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/Menu/Menu.dart';
import 'package:biomagnapro/Menu/OnBluetooth/SelectT.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:biomagnapro/onPlay.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import './DiscoveryPage.dart';
import 'BackgroundCollectingTask.dart';
import 'SelectBondedDevicePage.dart';


// import './helpers/LineChart.dart';

class MainPage extends StatefulWidget {
  final int treat;
  MainPage(this.treat);
  @override
  _MainPage createState() => new _MainPage();
}

class _MainPage extends State<MainPage> {
  BluetoothState _bluetoothState = BluetoothState.UNKNOWN;
  UserC userC=UserC("", " ", 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0);
  String _address = "...";
  String _name = "...";

  Timer _discoverableTimeoutTimer;
  int _discoverableTimeoutSecondsLeft = 0;

  BackgroundCollectingTask _collectingTask;

  bool _autoAcceptPairingRequests = false;

  @override
  void initState() {
    super.initState();

    // Get current state
    FlutterBluetoothSerial.instance.state.then((state) {
      setState(() {
        _bluetoothState = state;
      });
    });

    Future.doWhile(() async {
      // Wait if adapter not enabled
      if (await FlutterBluetoothSerial.instance.isEnabled) {
        return false;
      }
      await Future.delayed(Duration(milliseconds: 0xDD));
      return true;
    }).then((_) {
      // Update the address field
      FlutterBluetoothSerial.instance.address.then((address) {
        setState(() {
          _address = address;
        });
      });
    });

    FlutterBluetoothSerial.instance.name.then((name) {
      setState(() {
        _name = name;
      });
    });

    // Listen for futher state changes
    FlutterBluetoothSerial.instance
        .onStateChanged()
        .listen((BluetoothState state) {
      setState(() {
        _bluetoothState = state;

        // Discoverable mode is disabled when Bluetooth gets disabled
        _discoverableTimeoutTimer = null;
        _discoverableTimeoutSecondsLeft = 0;
      });
    });
  }

  @override
  void dispose() {
    FlutterBluetoothSerial.instance.setPairingRequestHandler(null);
    _collectingTask?.dispose();
    _discoverableTimeoutTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bluetooth'),
      ),
      body: Container(
        child: ListView(
          children: <Widget>[
             Container (
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Container (
                alignment: Alignment.center,
                child:Text("1",
                    style: TextStyle(
                        fontSize: Size_Title(),
                        fontWeight: FontWeight.w300,
                        color: SecondaryColor(),
                        wordSpacing: 2
                    )) ,
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(50.0),
                    border: Border.all(
                        color: SecondaryColor(),
                        width: 2.5
                    )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container (
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:  Text('Active Bluetooth',
                          style: TextStyle(
                              fontSize: Size_Normal(),
                              fontWeight: FontWeight.w400,
                              color: SecondaryColor(),
                              wordSpacing: 2
                          )),

                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(10, 10, 10, 10),
                      child:  Text('Check that your bluetooth is activated and correctly working',
                          style: TextStyle(
                              fontSize: Size_Normal()-6,
                              fontWeight: FontWeight.w300,
                              color: SecondaryColor(),
                              wordSpacing: 2
                          )),

                    ),
                    SwitchListTile(
                    title:  Text('Bluetooth',
                        style: TextStyle(
                            fontSize: Size_Normal(),
                            fontWeight: FontWeight.w300,
                            color: SecondaryColor(),
                            wordSpacing: 2
                        )),
                    value: _bluetoothState.isEnabled,
                    onChanged: (bool value) {
                      // Do the request and update with the true value then
                      future() async {
                        // async lambda seems to not working
                        if (value)
                          await FlutterBluetoothSerial.instance.requestEnable();
                        else
                          await FlutterBluetoothSerial.instance.requestDisable();
                      }

                      future().then((_) {
                        setState(() {});
                      });
                    },
                  ),
                    Divider(),
                    ListTile(
                      title:  Text('State of Bluetooth',
                          style: TextStyle(
                              fontSize: Size_Normal(),
                              fontWeight: FontWeight.w300,
                              color: SecondaryColor(),
                              wordSpacing: 2
                          )),
                      subtitle: Text(_bluetoothState.toString(),
                          style: TextStyle(
                              fontSize: Size_Normal()-7,
                              fontWeight: FontWeight.w300,

                              wordSpacing: 2
                          )),
                      trailing: FlatButton(
                        child: Icon(Icons.settings,size: 25,color: SecondaryColor(),),
                        onPressed: () {
                          FlutterBluetoothSerial.instance.openSettings();
                        },
                      ),
                    ),
                  ],

                ),
                decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(50.0),
                    border: Border.all(
                        color: SecondaryColor(),
                        width: 0.5
                    )
                ),
              ),
            ),

            Container (
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 20, 0, 20),
              child: Container (
                alignment: Alignment.center,
                child:Text("2",
                    style: TextStyle(
                        fontSize: Size_Title(),
                        fontWeight: FontWeight.w300,
                        color: SecondaryColor(),
                        wordSpacing: 2
                    )) ,
                width: 60,
                height: 60,

                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(50.0),
                    border: Border.all(
                        color: SecondaryColor(),
                        width: 2.5
                    )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 0),
              child: Container (
                alignment: Alignment.center,
                padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                child: Column(
                  children: [
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:  Text('Connect Dispositive',
                          style: TextStyle(
                              fontSize: Size_Normal(),
                              fontWeight: FontWeight.w400,
                              color: SecondaryColor(),
                              wordSpacing: 2
                          )),

                    ),
                    Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.fromLTRB(0, 10, 0, 10),
                      child:  Text('Press the Bluetooth button and select the dispositive',
                          style: TextStyle(
                              fontSize: Size_Normal()-6,
                              fontWeight: FontWeight.w300,
                              color: SecondaryColor(),
                              wordSpacing: 2
                          )),

                    ),
                    Container(
                      width: 160,
                      height:60,
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FlatButton(
                        child:Container (


                          child: Container (
                            alignment: Alignment.center,
                            child: Icon(Icons.bluetooth,size: 30,color: Colors.white,),
                            width: 60,
                            height: 60,

                            decoration: BoxDecoration(
                                color: SecondaryColor(),
                                borderRadius: new BorderRadius.circular(60.0),
                                border: Border.all(
                                    color: SecondaryColor(),
                                    width: 1.5
                                )
                            ),
                          ),
                        ),
                        onPressed: () async {
                          final BluetoothDevice selectedDevice =
                          await Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) {
                                return SelectBondedDevicePage(checkAvailability: false);
                              },
                            ),
                          );

                          if (selectedDevice != null) {
                            print('Connect -> selected ' + selectedDevice.address);
                            _startChat(context, selectedDevice);
                          } else {
                            print('Connect -> no device selected');
                          }
                        },
                      ),
                    ),
                  SizedBox(height: 10,)
                  ],

                ),
                decoration:BoxDecoration(
                    color: Colors.white,
                    borderRadius: new BorderRadius.circular(50.0),
                    border: Border.all(
                        color: SecondaryColor(),
                        width: 0.5
                    )
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
  void _startChat(BuildContext context, BluetoothDevice server) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) {
         // return onPlay(server);
          if(widget.treat==0)
            return SelectT(server: server);
          return PlayPage(server: server,i: widget.treat);
        },
      ),
    );
  }
}


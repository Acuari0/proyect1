/*import 'dart:convert';
import 'package:biomagnapro/Usages/BluetoothClass.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_blue/flutter_blue.dart';

import '../onPlay.dart';

class FindDevicesScreen extends StatefulWidget {
  final BluetoothClass bluetoothDevice;
  FindDevicesScreen(this.bluetoothDevice);

  @override
  _FindDevicesScreenState createState() => _FindDevicesScreenState();
}

class _FindDevicesScreenState extends State<FindDevicesScreen> {
  FlutterBlue flutterBlue = FlutterBlue.instance;
  List<ScanResult> list=[];
  bool refreshing=false;
  List<BluetoothService> _service;



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // Start scanning

   flutterBlue.connectedDevices.then((value){
     if(value.isNotEmpty){
       print("esta conectado a algo");
       Navigator.push(context,
           MaterialPageRoute(builder: (context) =>
               onPlay( value.first)));
     }
   }
   );

    setState(() {
      list=[];
      refreshing=true;
      flutterBlue.startScan(timeout: Duration(seconds: 4)).then((value) {
        setState(() {
          refreshing=false;
        });
        flutterBlue.scanResults.listen((results) {
          print("tomale");
        if(results.isNotEmpty){
          setState(() {
            print("alaaa"+results.first.device.name);
            list=results;

          });
        }
        // do something with scan results
        for (ScanResult r in results) {
          print('${r.device.name} found! rssi: ${r.rssi}');
        }
      });
      });
      flutterBlue.scanResults.listen((results) {
        print("tomale");
        if(results.isNotEmpty){
          setState(() {
            print("alaaa"+results.first.device.name);
            list=results;

          });
        }
        // do something with scan results
        for (ScanResult r in results) {
          print('${r.device.name} found! rssi: ${r.rssi}');
        }
      });



    });


  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Find Devices'),
      ),
      floatingActionButton:(refreshing)?FloatingActionButton(onPressed: (){

      },
      child:  RefreshProgressIndicator(),):
      FloatingActionButton(
        child: Icon(Icons.repeat,color: Colors.white,),
        onPressed: (){

          setState(() {
            list=[];
            refreshing=true;
            flutterBlue.startScan(timeout: Duration(seconds: 4)).then((value) {
              setState(() {
                refreshing=false;
              });
              flutterBlue.scanResults.listen((results) {
                if(results.isNotEmpty){
                  setState(() {
                    print("alaaa"+results.first.device.name);
                    list=results;
                  });

                }
                // do something with scan results
                for (ScanResult r in results) {
                  print('${r.device.name} found! rssi: ${r.rssi}');
                }
              });
            });
            flutterBlue.scanResults.listen((results) {
              print("tomale");
              if(results.isNotEmpty){
                setState(() {
                  print("alaaa"+results.first.device.name);
                  list=results;

                });
              }
              // do something with scan results
              for (ScanResult r in results) {
                print('${r.device.name} found! rssi: ${r.rssi}');
              }
            });
          });

// Stop scanning

        },
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: 10,horizontal: 20),
        child: ListView.builder(
            physics: ScrollPhysics(),
            itemCount: list.length,
            shrinkWrap: true,
            itemBuilder: (context, int index){
              final item= list[index];
              return ListTile(
                title: Text(item.device.name),
                subtitle:Text(item.device.id.id) ,
                trailing: Text(item.rssi.toString()),
                onTap: ()   async {
                 flutterBlue.stopScan();
                 try {
                   await item.device.connect(autoConnect: false);
                 } catch (e) {
                   if (e.code != 'already_connected') {
                     throw e;
                   }
                 } finally {
                   _service = await item.device.discoverServices();
                   print("conectado");
                   Navigator.push(context,
                       MaterialPageRoute(builder: (context) =>
                           onPlay( item.device)));
                 }
  




                   /* await item.device.connect().then((value) async {
                      print("conected");
                      List<BluetoothService> services = await item.device.discoverServices();
                      services.forEach((service) async {
                        await service.characteristics.first.write(utf8.encode('#')).then((value) async {
                          print("enviar");

                        });

                      });
                    });*/





                  //await send(utf8.encode('#')
                },
              );

            }
        ),
      ),
    );
  }
}*/
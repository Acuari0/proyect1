import 'package:biomagnapro/Database/DatabaseFuntion.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/LoginWidget/Initial.dart';
import 'package:biomagnapro/LoginWidget/LogFire.dart';
import 'package:biomagnapro/Menu/ChangeTreat.dart';
import 'package:biomagnapro/Menu/OnBluetooth/SelectT.dart';
import 'package:biomagnapro/Menu/Principal.dart';
import 'package:biomagnapro/Paypal/PaypalWidget.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:biomagnapro/Usages/BluetoothClass.dart';
import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Info.dart';
import 'help.dart';

class Menu extends StatefulWidget {

  @override
  _MenuState createState() => _MenuState();
}

class _MenuState extends State<Menu> {
  int _page = 0;
  bool isBConnected=false,isinitial=false;
  GlobalKey _bottomNavigationKey = GlobalKey();
  UserC userC=UserC("", "", 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0);
  //BluetoothClass bluetoothDevice;

  Widget Navigatorr (){

    if(_page==0)
      return Connect(treat: userC.treat,email: userC.email,);
    if(_page==1)
      return Info(userC);

    if(_page==2)
      return makePayment();

    return ChangeTreat(userC,/*bluetoothDevice*/);
  }
  String SNav (){

    if(_page==0)
      return "";
    if(_page==1)
      return "";
    if(_page==2)
      return "";
    return "";
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStateStepsister();

    DatabaseService.getUser().then((value) {
      setState(() {
        userC=value;
      });
    });

  }
  getStateStepsister() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      isinitial = (prefs.getBool('initial') ?? false);
      if(!isinitial){
        Navigator.push(context,
            MaterialPageRoute(builder: (context) =>
                Start())).then((value) {
          setState(() {
            isinitial=true;
            setSteateStepsister();
          });
        });
      }


    });
  }
  setSteateStepsister() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('initial', isinitial);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
          appBar: AppBar(
            title: Text(SNav()) ,
            backgroundColor: Color.fromARGB(208, 20,56, 100),
            leading: IconButton(
              icon: Icon(Icons.power_settings_new),
              color: Colors.white,
              onPressed: (){context.read<AuthService>().signOut();;},
            ),
            actions: [
              /*Row(
                children: [
                  Text("Credits: "+userC.credits.toString()+" ",
                  style: TextStyle(
                    fontSize:Size_Normal(),
                    fontWeight: FontWeight.w300,
                    color: Colors.white,
                  ),),
                  Icon(Icons.monetization_on,size: 20,color: Colors.white,),
                  SizedBox(width: 10,)

                ],
              )*/
            ],

          ),
          bottomNavigationBar: CurvedNavigationBar(
            key: _bottomNavigationKey,
            index: 0,
            height: 50.0,
            items: <Widget>[
              Icon(Icons.play_arrow, size: 30,color: Colors.white,),
          Icon(Icons.info_outline, size: 30,color: Colors.white),
              Icon(Icons.shopping_cart, size: 30,color: Colors.white),
              Icon(Icons.settings, size: 30,color: Colors.white),

            ],
            color: Color.fromARGB(199, 126, 207, 215),
            buttonBackgroundColor: SecondaryColor(),
            backgroundColor: SecondaryColor(),
            animationCurve: Curves.easeInOut,
            animationDuration: Duration(milliseconds: 600),
            onTap: (index) {
              setState(() {
                _page = index;
              });
            },
          ),
          body: Container(
            color: Colors.blueAccent,
            child: Navigatorr(),
          )),
    );
  }
}


import 'package:biomagnapro/Bluetooth/Play.dart';
import 'package:biomagnapro/Database/User.dart';
import 'package:biomagnapro/Menu/Menu.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bluetooth_serial/flutter_bluetooth_serial.dart';
import 'AppUseless.dart';

Widget Tiles ( context,String title,  BluetoothDevice server,int i,UserC userC){
  return Container(

    width: MediaQuery.of(context).size.width-40,
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: new BorderRadius.circular(20.0),
        border: Border.all(
            color: SecondaryColor(),
            width: 0.5
        )
    ),
    child: ListTile(
      onTap: (){
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) {
              Map<String,dynamic> childrenPathValueMap = {};
              if(userC.key.isNotEmpty) {
                childrenPathValueMap['users/' + userC.key + '/Treat'] = i;
                FirebaseDatabase.instance.reference().update(
                    childrenPathValueMap);

                return PlayPage(server: server, i: i);
              }
            },
          ),
        );
      },
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

Widget Tiles2 ( context,String title, int i,UserC userC){
  return Container(

    width: MediaQuery.of(context).size.width-40,
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20.0),
        border: Border.all(
            color: SecondaryColor(),
            width: 0.5
        )
    ),
    child: ListTile(
      onTap: (){

        OK(context, userC, i);

      },
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

void OK(context,UserC userC,int i) {
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


                            print(userC.key);
                            userC.credits--;
                            userC.treat=i;
                            Map<String,dynamic> childrenPathValueMap = {};

                            childrenPathValueMap['users/'+userC.key+'/Treat'] = i;
                            childrenPathValueMap['users/'+userC.key+'/Creditos'] = userC.credits;
                            FirebaseDatabase.instance.reference().update(childrenPathValueMap);


                          }
                          Navigator.pop(context);
                          OKs(context);
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

void OKs(context) {
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
                Text("The Change is Sucefull",
                  style: TextStyle(
                    color: SecondaryColor(),
                    fontSize:Size_Normal(),
                    fontWeight: FontWeight.w300,
                  ),),
                SizedBox(height: 20,),
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
                      Navigator.of(context).popUntil(ModalRoute.withName('/'));
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) =>
                              Menu()));
                    },),
                ),
              ],
            ),
          )
      );
    },
  );
}

Widget Tiles3 ( context,String title,double price, int i){
  return Container(

    width: MediaQuery.of(context).size.width-40,
    height: 50,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: new BorderRadius.circular(20.0),
        border: Border.all(
            color: Colors.black,
            width: 0.5
        )
    ),
    child: ListTile(
      onTap: (){



      },
      title: Text(title,
        style: TextStyle(
          fontSize:Size_Normal(),
          fontWeight: FontWeight.w400,
          color: Colors.black,
        ),),
      leading: Icon(Icons.star,size: 30,color: Colors.yellow,),
      trailing: Text(price.toStringAsFixed(2)+" US\$",
        style: TextStyle(
          fontSize:Size_Title(),
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),),

    ),
  );
}
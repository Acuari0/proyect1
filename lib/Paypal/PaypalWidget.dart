import 'package:biomagnapro/Usages/Tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'PaypalPayment.dart';

class makePayment extends StatefulWidget {

  @override
  _makePaymentState createState() => _makePaymentState();
}

class _makePaymentState extends State<makePayment> {

  TextStyle style = TextStyle(fontFamily: 'Open Sans', fontSize: 15.0);
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
          Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 10,),
                  Container(
                      alignment: Alignment.center,
                      padding: EdgeInsets.all(10),
                      child: Text(
                        'Marketplace',
                        style: TextStyle(
                            color: Colors.white,

                            fontSize: 30,
                            letterSpacing: 2),
                      )),
                  Container(width:100,child: Divider(color: Colors.white,thickness: 2,))
                ],
              ),
              Container(
                padding: EdgeInsets.all(20),
                child: Text("Select between different treatments for addictions by tapping over them. If you don't have available treatment sessions you can purchase more sessions by tapping over the treatment you would like to buy.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize:15,
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                ),),
              ),
              FlatButton(onPressed: (){},
                  child: Image.asset("assets/fumar.png")),
              SizedBox(height: 10,),
              FlatButton(onPressed: (){},
                  child: Image.asset("assets/alcohol.png")),
              SizedBox(height: 10,),
              FlatButton(onPressed: (){},
                  child: Image.asset("assets/droga.png"))
            ],
          )
        ],
      ),
    );
   /* return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: new Scaffold(
          backgroundColor: Colors.white,

          body:Container(
            alignment: Alignment.center,
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage("assets/paypal.png"),
                          fit: BoxFit.fill
                      )
                  ),
                  width: MediaQuery.of(context).size.width-20,
                  height: 100,
                ),
                SizedBox(height: 20,),
                Tiles3(context, "Buy 10 credits",5, 0),
                Divider(),
                Tiles3(context, "Buy 50 credits",20, 0),
                Divider(),
                Tiles3(context, "Buy 100 credits",35, 0)
              ],
            ),
          )
          Container(
              width: MediaQuery.of(context).size.width,
              child: Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      onPressed: (){

                        // make PayPal payment

                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {

                                // payment done
                                print('order id: '+number);

                              },
                            ),
                          ),
                        );


                      },
                      child: Text('Pay with Paypal', textAlign: TextAlign.center,),
                    ),

                  ],
                ),
              )
          ),
        )
    );*/
  }

}
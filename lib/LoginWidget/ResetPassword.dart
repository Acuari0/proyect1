import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'LogFire.dart';
import 'Validate.dart';

class ResetPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<ResetPage> {
  TextEditingController nameController = TextEditingController();
  String Message=" ";


  bool load=false,sended=false;

  void _onLoading() {

    context.read<AuthService>().ResetPassword(
        email: nameController.text.trim(),
    ).then((value){
      if(value=="Entro") {
        setState(() {
          Send();
          Message="A Check out your email!";
        });

      }
      else{
        setState(() {
          Message=value;
        });


      }

    });
    /*context.read<AuthService>().getMessage()=="Entro"*/

  }

  Future _login() async{
    setState((){
      load= false;
    });
  }
  void Send(){
    showDialog(context: context, barrierDismissible: false,
        builder: (BuildContext context){

      return Dialog(
        child: Container(width: 200,
        height:200,
        child: Column(children: [
          Padding(padding: EdgeInsets.all(10),
          child: Text("Reset password",style: TextStyle(
            color: Colors.blue,
            fontWeight: FontWeight.w500
          ),),),
          Padding(padding: EdgeInsets.all(10),
            child: Text("An email with instruccions has been sent  to your email account.",style: TextStyle(
              color: Colors.blue,
            ),),),
          FlatButton(
            child: Container(
              height: 50,
              color: Colors.blue,
              alignment: Alignment.center,
              padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
              child: Text("Got it!",
                style: TextStyle(

                  fontWeight: FontWeight.w300,
                    color:Colors.white
                ),),
            ),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
        ],),),
      );
        });
  }

  @override
  Widget build(BuildContext context) {
    return  MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          backgroundColor: Color.fromARGB(250,30, 120,167),
          shadowColor: Colors.transparent,
          leading: Container(
            height: 20,
            width: 20,
            padding: EdgeInsets.all(5),
            decoration: BoxDecoration(
              color: Color.fromARGB(200, 126, 207, 215),
              borderRadius:BorderRadius.all(Radius.circular(40)), ),

            child: IconButton(

              icon: Icon(Icons.arrow_back),
              color: Colors.white,
              onPressed: (){Navigator.pop(context);},
            ),
          ),
        ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage("assets/fondo.png"),
                      fit: BoxFit.fill
                  )
              ),
            ),
            Container(
              alignment: Alignment.center,
              child: Padding(
                  padding: EdgeInsets.all(10),

                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(width: 200,
                          child: Column(
                            children: [

                              Container(
                                  alignment: Alignment.center,
                                  padding: EdgeInsets.all(10),
                                  child: Text(
                                    'Forgot Password',
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500,
                                        fontSize: 20),
                                  )),
                              Container(width:120,child: Divider(color: Colors.white,thickness: 2,))
                            ],
                          ),),
                        SizedBox(height: 20,),
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            style: TextStyle(
                                color: Color.fromARGB(200, 126, 207, 215)
                            ),
                            controller: nameController,
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

                              labelText: 'Email',
                            ),
                          ),
                        ),
                        Container(
                            width: 300,
                            height: 80,
                            padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                            decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(40)), ),
                            child: RaisedButton(
                              textColor: Color.fromARGB(200, 126, 207, 215),
                              color: Colors.white,
                              shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                              ),
                              child: Text('Reset'),
                              onPressed: () {
                                _onLoading();

                              },
                            )),
                        /*Container(
                            height: 50,
                            padding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                            child: RaisedButton(
                              textColor: Colors.white,
                              color: Colors.blue,
                              child: Text('Register'),
                              onPressed: () {
                                _onLoading();

                              }
                            )),*/
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(Message,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 15),
                            )),
                        SizedBox(height: 200,),
                      ],
                    ),
                  )),
            ),
          ],
        ),
      ),
    );
  }
}

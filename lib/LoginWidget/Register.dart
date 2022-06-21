/* Johan Guillen

* Dedicado a mi portuguesa
* no es nada romantico , solo quiero distraerme jaja

* */

import 'package:biomagnapro/Database/User.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'LogFire.dart';
import 'Validate.dart';


class RegisterPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<RegisterPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  String Message=" ";

  bool load=false,obs=true,TermCond=false,LegalDis=false,PP=false;

  void _onLoading() {
    load=true;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );
      },
    );
    context.read<AuthService>().signUp(
      user: UserC("", nameController.text.trim(), 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0)
        /*email: nameController.text.trim()*/,
        password: passwordController.text.trim()
    ).then((value){
      setState(() {
        setSteateStepsister();
      });
      if(value=="Entro") {
        _login();
      }
      else{
        Message=value;
        _login();
      }
      Navigator.pop(context);
    });
    /*context.read<AuthService>().getMessage()=="Entro"*/
    _login();
  }

  Future _login() async{
    setState((){
      load= false;
    });
  }

  setSteateStepsister() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('initial', false);
  }



  @override
  Widget build(BuildContext context) {
    return  Scaffold(
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
                Padding(
                    padding: EdgeInsets.all(10),
                    child: ListView(
                      children: <Widget>[
                        Container(width: 150,
                        child: Column(
                          children: [
                            Container(
                              height: 100,
                              width: 100,
                              child: Image.asset("assets/person.png"),
                            ),
                            SizedBox(height: 10,),
                            Container(
                                alignment: Alignment.center,
                                padding: EdgeInsets.all(10),
                                child: Text(
                                  'Register',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 20),
                                )),
                            Container(width:120,child: Divider(color: Colors.white,thickness: 2,))
                          ],
                        ),),

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
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            obscureText: obs,
                            style: TextStyle(
                                color: Color.fromARGB(200, 126, 207, 215)
                            ),
                            controller: passwordController,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                  icon:Icon(
                                    Icons.remove_red_eye_outlined,color:Color.fromARGB(200, 126, 207, 215),),
                              onPressed: (){
                                if(obs){
                                  setState(() {
                                    obs=false;
                                  });
                                }
                                else{
                                  setState(() {
                                    obs=true;
                                  });
                                }
                              },),
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

                              labelText: 'Password',
                            ),
                          ),
                        ),
                        Container(
                          width: 300,
                          padding: EdgeInsets.all(10),
                          child: TextField(
                            obscureText: obs,
                            style: TextStyle(
                                color: Color.fromARGB(200, 126, 207, 215)
                            ),
                            controller: passwordConfirmController,
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

                              labelText: 'Confirm Password',
                            ),
                          ),
                        ),
                        Row(children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Color.fromARGB(200, 126, 207, 215),
                            ),
                            child: Checkbox(value: TermCond, onChanged: (state){
                              setState(() {
                                TermCond=state;
                              });
                            }),
                          ),
                          Container(child:
                            Text("I accept the Terms & Conditions",style:
                              TextStyle(
                                color: Color.fromARGB(200, 126, 207, 215),
                                decoration: TextDecoration.underline
                              ),),)
                        ],),
                        Row(children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Color.fromARGB(200, 126, 207, 215),
                            ),
                            child: Checkbox(value: LegalDis, onChanged: (state){
                              setState(() {
                                LegalDis=state;
                              });
                            }),
                          ),
                          Container(child:
                          Text("I accept Legal Disclaimer",style:
                          TextStyle(
                              color: Color.fromARGB(200, 126, 207, 215),
                              decoration: TextDecoration.underline
                          ),),)
                        ],),
                        Row(children: [
                          Theme(
                            data: ThemeData(
                              unselectedWidgetColor: Color.fromARGB(200, 126, 207, 215),
                            ),
                            child: Checkbox(value: PP, onChanged: (state){
                              setState(() {
                                PP=state;
                              });
                            }),
                          ),
                          Container(child:
                          Text("I accept the Privacy Policy",style:
                          TextStyle(
                              color: Color.fromARGB(200, 126, 207, 215),
                              decoration: TextDecoration.underline
                          ),),)
                        ],),
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
                              child: Text('Register'),
                              onPressed: () {
                                setState(() {
                                  if(passwordConfirmController.text.toString()==
                                      passwordController.text.toString()) {
                                    if(TermCond && LegalDis && PP){
                                      setState(() {
                                        load=true;
                                      });
                                      context.read<AuthService>().signUp(
                                          user: UserC("", nameController.text.trim(), 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0, 0,0)
                                          /*email: nameController.text.trim()*/,
                                          password: passwordController.text.trim()
                                      ).then((value){
                                        setState(() {
                                          setSteateStepsister();
                                          Message=value;
                                          load=false;
                                        });

                                      });
                                    }
                                    else{
                                      Message="You don't accept something";
                                    }

                                  }
                                  else
                                    Message="Your password must have 6 characters and must be equal ";
                                });

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
                                setState(() {
                                  if(passwordConfirmController.text.toString()==
                                      passwordController.text.toString()) {
                                   _onLoading();
                                  }
                                  else
                                    Message="Something is wrong with your data";
                                });

                              },
                            )),*/
                        Container(
                            alignment: Alignment.center,
                            padding: EdgeInsets.all(10),
                            child: Text(Message,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500,
                                  fontSize: 10),
                            )),

                      ],
                    )),
                (!load)?SizedBox():Container(
                  alignment: Alignment.center,
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  color: Colors.black54,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [new CircularProgressIndicator(),
                      Text("\nLoading...",style: TextStyle(
                        color: Colors.white,
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),)],
                  ),

                ),
              ],
            ),

    );
  }
}


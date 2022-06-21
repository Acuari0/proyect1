import 'package:biomagnapro/LoginWidget/LogFire.dart';
import 'package:biomagnapro/LoginWidget/Register.dart';
import 'package:biomagnapro/LoginWidget/ResetPassword.dart';
import 'package:biomagnapro/Menu/Menu.dart';
import 'package:biomagnapro/Usages/AppUseless.dart';
import 'package:biomagnapro/itsok.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';


class LoginScreen extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MultiProvider(
        providers: [
          Provider<AuthService>(
            create: (_)=> AuthService(FirebaseAuth.instance),),
          StreamProvider(
              create: (context)=> context.read<AuthService>().authStateChanges),

        ],
        child: MaterialApp(home: AuthWrapper(),));
  }

}

class AuthWrapper extends StatelessWidget{
  const AuthWrapper ({
    Key key,
  }): super(key: key);

  @override
  Widget build(BuildContext context) {
    final firebaseUser = context.watch<User>();

    if (firebaseUser != null){
      return Menu();
    }
    return LoginPage();
  }

}

class LoginPage extends StatefulWidget {

  @override
  State<StatefulWidget> createState() => new _State();
}

class _State extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  String Message=" ";

  bool load=false;

  Widget _onLoading()  {


        return Dialog(
          child: new Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              new CircularProgressIndicator(),
              new Text("Loading"),
            ],
          ),
        );

    /* context.read<AuthService>().signIn(
        email: nameController.text.trim(),
        password: passwordController.text.trim()
    ).then((value) async {
      if(value=="Entro") {

         await _login();


      }
      else{

        Message=value;
         _login();

      }

    });
    /*context.read<AuthService>().getMessage()=="Entro"*/
   _login();*/
  }

  Future _login() async{
    setState((){
      load= false;

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Color.fromARGB(200,17, 124,167),

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
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                          alignment: Alignment.center,
                          padding: EdgeInsets.all(10),
                          child: Image.asset("assets/logoblanco.png")),
                      SizedBox(height: 90,),
                      Container(
                        width: 300,
                        padding: EdgeInsets.all(10),
                        child: TextField(
                          style: TextStyle(
                              color: Color.fromARGB(200, 126, 207, 215)
                          ),
                          controller: nameController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.person,color: Color.fromARGB(200, 126, 207, 215),),
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
                        padding: EdgeInsets.fromLTRB(10, 10, 10, 0),

                        width: 300,
                        child: TextField(
                          style: TextStyle(
                            color: Color.fromARGB(200, 126, 207, 215)
                          ),
                          obscureText: true,
                          controller: passwordController,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock,color: Color.fromARGB(200, 126, 207, 215),),
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
                          height: 80,
                          padding: EdgeInsets.fromLTRB(10, 20, 10, 0),
                          decoration: BoxDecoration(borderRadius:BorderRadius.all(Radius.circular(40)), ),
                          child: RaisedButton(
                            textColor: Color.fromARGB(200, 126, 207, 215),
                            color: Colors.white,
                            shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(30.0),
                            ),
                            child: Text('Login'),
                            onPressed: () {
                              setState(() {
                                load=true;
                              });
                              context.read<AuthService>().signIn(
                                  email: nameController.text.trim(),
                                  password: passwordController.text.trim()
                              ).then((value) {
                                load=false;
                                Message=value;
                              });
                              //_onLoading();

                            },
                          )),
                      FlatButton(
                        onPressed: (){
                          //forgot password screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => ResetPage()),
                          );
                        },
                        textColor: Color.fromARGB(200, 126, 207, 215),
                        child: Text('Forgot Password'),
                      ),

                      Container(
                          child: Row(
                            children: <Widget>[
                              Text('Does not have account?',style:
                                TextStyle(
                                  color: Color.fromARGB(200, 126, 207, 215),
                                ),),
                              FlatButton(
                                textColor: Color.fromARGB(200, 126, 207, 215),
                                child: Text(
                                  'Sign in',
                                  style: TextStyle(fontSize: 20),
                                ),
                                onPressed: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(builder: (context) => RegisterPage()),
                                  );
                                },
                              )
                            ],
                            mainAxisAlignment: MainAxisAlignment.center,
                          )),
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
              ),
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

        ));
  }
}
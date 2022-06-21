import 'package:biomagnapro/Menu/Menu.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Start extends StatefulWidget{
  @override
  _StartState createState() => _StartState();
}

class _StartState extends State<Start> {
  CarouselController buttonCarouselController = CarouselController();
  int control=0;
  List<Widget> widgetList=[
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/page1.png"),
              fit: BoxFit.cover
          )
      ),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/page2.png"),
              fit: BoxFit.cover
          )
      ),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/page3.png"),
              fit: BoxFit.cover
          )
      ),
    ),
    Container(
      decoration: BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/page4.png"),
              fit: BoxFit.cover
          )
      ),
    ),
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Column(
              children: <Widget>[
                CarouselSlider(
                  items: widgetList,
                  carouselController: buttonCarouselController,
                  options: CarouselOptions(
                      height: MediaQuery
                          .of(context)
                          .size
                          .height -100,
                      autoPlay: false,
                      enableInfiniteScroll: false,
                      enlargeCenterPage: true,
                      viewportFraction: 0.9,
                      aspectRatio: 2.0,
                      initialPage: 0,
                      onPageChanged: (index, reason) {
                        setState(() {
                          control = index;
                        });
                      }
                  ),
                ),
                //aqui

                SizedBox(height: 10,),
                Column(
                  children: [ Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (control==0)?SizedBox(width: 100,):Container(
                        width: 100,
                        child: FlatButton(
                          onPressed: (){
                            buttonCarouselController.previousPage();
                          },
                          child: Text("Back",style: TextStyle(
                            fontSize:15,

                            color: Colors.blue,
                          ),),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: widgetList.map((url) {
                          int index = widgetList.indexOf(url);
                          return Container(
                            width: 8.0,
                            height: 8.0,
                            margin: EdgeInsets.symmetric(
                                vertical: 10.0, horizontal: 2.0),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: control == index
                                  ? Colors.blue
                                  : Color.fromRGBO(0, 0, 0, 0.4),
                            ),
                          );
                        }).toList(),
                      ),
                      (control==3)?Container(
                        width: 100,
                        child: FlatButton(
                          onPressed: () async {

                              SharedPreferences prefs = await SharedPreferences.getInstance();
                              await prefs.setBool('initial',true );

                            Navigator.push(context, MaterialPageRoute(builder: (context)=>Menu()));
                          },
                          child: Text("Finish",style: TextStyle(
                            fontSize:15,

                            color: Colors.blue,
                          ),),
                        ),
                      ):Container(
                        width: 100,
                        child: FlatButton(
                          onPressed: (){
                            buttonCarouselController.nextPage();
                          },
                          child: Text("Next",style: TextStyle(
                            fontSize:15,

                            color: Colors.blue,
                          ),),
                        ),
                      ),
                    ],
                  ),

                  ],
                ),      ]),
        )
    );
  }

}
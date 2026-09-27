import 'dart:async';

import 'package:flutter/material.dart';
import 'package:movie_search_app/screens/bottomscreen.dart';
import 'dart:async';

import 'package:movie_search_app/screens/homescreen.dart';
class splashscreen extends StatefulWidget {
  const splashscreen({super.key});

  @override
  State<splashscreen> createState() => _splashscreenState();
}

class _splashscreenState extends State<splashscreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 1),(){
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>bottomscreen()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(child:Image.asset("images/background.png",fit: BoxFit.cover,)),
          Positioned(
              top: 310,
              left: 110,
              child: Image.asset("images/logo.png",height: 130,width: 200,)),
          Positioned(
              top: 450,
              left: 115,
              child: RichText(text: TextSpan(children: [
                TextSpan(text: "Show",style: TextStyle(fontWeight: FontWeight.bold,color: Colors.white,fontSize: 40)),
                TextSpan(text: "Time",style: TextStyle(fontWeight: FontWeight.bold,color: Color(0xFF9840FA),fontSize: 40))

          ]))),
          Positioned(
            top: 500,
            left: 145,
            child: Column(
              children: [
                Text("Discover Amazing",style: TextStyle(fontSize: 16,color: Colors.white,fontWeight: FontWeight.w300),),
                Text("TV Shows",style: TextStyle(fontSize: 15,color: Colors.white,fontWeight: FontWeight.w300),)
              ],
            ),
          ),
          Positioned(
            top: 730,
             left: 100,
             child:  SizedBox(
               width: 200,
               child: LinearProgressIndicator(
                  value: 0.7, // 70% filled
                  minHeight: 4,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: Color(0xFF17202E),
                  color: Color(0xFF4B5DFF),
                ),
             )
          )

        ],
      ),
    );
  }
}

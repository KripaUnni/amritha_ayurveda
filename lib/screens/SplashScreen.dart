import 'dart:async';
import 'dart:developer';

import 'package:amritha_ayurveda/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_animate/flutter_animate.dart';


import 'package:flutter_svg/flutter_svg.dart';

import 'LoginScreen.dart'; 


class SplashScreen extends StatefulWidget{
  const SplashScreen({super.key});
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}
class _SplashScreenState extends State<SplashScreen>{
  bool? isLogin;
  @override
  void initState() {
    super.initState();
    _checkSession();
  }
  void _checkSession() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

   bool? isLogin = prefs.getBool('isLoggedIn') ?? false;

    if(isLogin){
      Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  const HomeScreen()));
    });

    }else{
      Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) =>  LoginScreen()));
    });

    }
    log("isloggedin = " + isLogin.toString());
  }
  Widget build(BuildContext context){
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Container(
            decoration: BoxDecoration(image: DecorationImage(image: AssetImage("assets/bg.png"))),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                flex: 4,
                child: Container(
                  child: Center( 
                  child: SvgPicture.asset( 
                    'assets/logo1.svg', 
                    semanticsLabel: 'My SVG Image', 
                    height: 100, 
                    width: 70, 
                  ), 
                ).animate()
              .fadeIn(duration: 3000.ms)
              .then(delay: 1200.ms)
              .slideX(end: -0.2, duration: 2000.ms)
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
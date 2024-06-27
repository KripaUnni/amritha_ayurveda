import 'dart:convert';
import 'dart:developer';
import 'package:amritha_ayurveda/screens/HomeScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../webservice/webservice.dart';

class LoginScreen extends StatefulWidget{
  @override
  State<LoginScreen> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginScreen> {
  String? username,password;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  @override
  void initState(){
    super.initState();
  }

login(String username,String password) async{
  try{
   print(Webservice.mainurl+"Login");
    print(username);
    print(password);
    var result;
    final Map<String,dynamic> loginData={
      'username':username,
      'password':password,
    };

    final response =await http.post(
      Uri.parse(Webservice.mainurl+"Login"),
      body:loginData,
    );
    print(response);
    print(response.statusCode);
    if(response.statusCode==200){
      print(response.body);
        log("login successfully completed");
        Map<String, dynamic> responseData = jsonDecode(response.body);
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('token', responseData['token']);
        prefs.setBool("isLoggedIn",true);
        Navigator.pushReplacement(context,MaterialPageRoute(
          builder:(context){
            return HomeScreen();
          }
          ));
      }else{
       log("login failed");
       ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        duration:Duration(seconds:3),
        behavior: SnackBarBehavior.floating,
        padding:EdgeInsets.all(15.0),
        shape:RoundedRectangleBorder(
          borderRadius:BorderRadius.all(Radius.circular(10))),
         content:Text("LOGIN FAILED!!!",
         textAlign: TextAlign.center,
         style:TextStyle(
          fontSize:18,
          color: Colors.white,
          )),
       ));
       result={log(json.decode(response.body)['error'].toString())};
    }
    return result;
  }catch(e){
    log(e.toString());
  }
}

@override
Widget build(BuildContext context){
  return Scaffold(
    body:SingleChildScrollView(
      child: Form(
        key:_formkey,
        child: Center(
          child: Column(
            children: [
              Stack(
                children: [
                  Image(
                      image: AssetImage("assets/frame.png")
                    ),
                    Image(
                      image: AssetImage("assets/logo2.png")
                    ),
                ]
              ),
              Padding(
              padding:EdgeInsets.all(8.0),
              child: Text(
                "Login Or Register To Book Your Appointments",
                style:TextStyle(
                  color:Colors.black,
                  fontSize:24,
                fontWeight  :FontWeight.bold,
                )
              ),
              ),
             SizedBox(height:50),
             Padding(
              padding:EdgeInsets.all(8.0),
             child: Container(
              height: 50,
              width:MediaQuery.of(context).size.width,
              decoration:BoxDecoration(
                color:Colors.grey,
                borderRadius:BorderRadius.all(Radius.circular(10)),
              ),
              child:Padding(
              padding:EdgeInsets.symmetric(horizontal:15),
              child:Center(
                child:TextFormField(
                  style:TextStyle(
                    fontSize: 15,
                  ),
                  decoration:InputDecoration.collapsed(
                    hintText:'Username',
                    ),
                    onChanged: (text){
                      setState(() {
                        username=text;
                      });
                    },
                    validator: (value){
                      if(value!.isEmpty){
                        return 'Enter your username text';
                      }
                      return null;
                    },
                ),
              ),
              ),
             ),
             ),
             Padding(
              padding:EdgeInsets.all(8.0),
              child: Container(
                height: 50,
                width:MediaQuery.of(context).size.width,
                decoration:const BoxDecoration(
                color:Colors.grey,
                borderRadius: BorderRadius.all(Radius.circular(10)),                 
                ),
                child:Padding(
                  padding:const EdgeInsets.symmetric(horizontal: 15),
                  child:Center(
                    child:TextFormField(
                      obscureText:true,
                      style:const TextStyle( 
                        fontSize:15,
                      ),
                      decoration:const InputDecoration.collapsed(
                        hintText:'Password',
                      ),
                      onChanged:(text){
                        setState((){
                          password=text;
                        });
                      },
                      validator:(value){
                        if(value!.isEmpty){
                          return'Enter your password text';
                        }
                        return null;
                      },
                    ))
                  ),
              ),
              ),
              SizedBox(height: 30),
              Padding(
                padding:EdgeInsets.all(8.0),
                child: Container(
                  width:MediaQuery.of(context).size.width/2,
                  height: 50,
                  child:TextButton(
                    style:TextButton.styleFrom(
                      shape:RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(20)),
                        primary:Colors.white,
                       backgroundColor:Colors.grey),
                      onPressed:() {
                        if(_formkey.currentState!.validate()){
                          log("username="+username.toString());
                          log("password="+password.toString());  
                          login(username.toString(),password.toString());                    
                       }
                      } ,
                      child:const Text(
                       "Login",
                       style:TextStyle(
                        fontSize:18,
                        color:Colors.white,
                       ),
                      ),                   
                  ),
                ),                 
                ),
            ],
          )
        )      )
    )
  );
}}
    
 
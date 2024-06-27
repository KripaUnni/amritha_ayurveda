import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget{
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomePageState();
}
class _HomePageState extends State<HomeScreen>{
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 60,
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.black,
        titleTextStyle: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        title: const Text("Home"),
      ),
    );
  }
}
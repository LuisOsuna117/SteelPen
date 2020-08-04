import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("BLoC Aprendido"),),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Text('Congratulations'),
      ),
    );
  }
}
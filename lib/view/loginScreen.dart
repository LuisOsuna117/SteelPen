import 'package:flutter/material.dart';
//import 'package:steelpen/logic/login/login_bloc.dart';
class LoginScreen extends StatefulWidget{
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        child: Column(
          children: <Widget>[
            TextFormField(),
            TextFormField(),
            RaisedButton(onPressed: (){},)
          ],
        ),
      ),
    );
  }

}
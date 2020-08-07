import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:steelpen/logic/login/login_bloc.dart';
import 'package:steelpen/view/loginScreen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/login/login_logic.dart';
void main() => runApp(MyApp());


class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: BlocProvider(
    create: (_) => LoginBloc(logic: MainLogic()),
    child: LoginScreen(),
      ),
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/logic/purchases/purchases_bloc.dart';

class PurchasesScreen extends StatefulWidget {
  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  TextStyle mainStyle = TextStyle(
      color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => PurchasesBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.lightBlue),
        ),
        drawer: CustomDrawer(),
        body: BlocListener<PurchasesBloc, PurchasesState>(
          listener: (context, state) {},
          child: BlocBuilder<PurchasesBloc, PurchasesState>(
              builder: (BuildContext context, state) {
                return ListView(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
                      child: Text(
                        'Compras',
                        style: mainStyle,
                      ),
                    ),
                  ],
                );
              }),
        ),
      ),
    );
  }
}

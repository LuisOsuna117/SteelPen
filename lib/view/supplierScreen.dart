import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/components/recyclable/tableView.dart';
import 'package:steelpen/logic/supplier/supplier_bloc.dart';

class SupplierScreen extends StatefulWidget {
  @override
  _SupplierScreenState createState() => _SupplierScreenState();
}

class _SupplierScreenState extends State<SupplierScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      drawer: CustomDrawer(),
      backgroundColor: Colors.white,
      body: BlocListener<SupplierBloc, SupplierState>(
        listener: (context, state) {},
        child: BlocBuilder<SupplierBloc, SupplierState>(
            builder: (BuildContext context, state) {
          if (state is SupplierInitial) {
            BlocProvider.of<SupplierBloc>(context).add(LoadSuppliers());
          }
          return Column(
            children: <Widget>[
              Stack(
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: Text(
                          "Proveedores",
                          style: TextStyle(
                              color: Colors.lightBlue,
                              fontSize: 24,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 14, 24, 0),
                        child: IconButton(
                          icon: Icon(Icons.add),
                          onPressed: () {},
                          color: Colors.lightBlue,
                          iconSize: 26,
                        ),
                      )
                    ],
                  )
                ],
              ),
              if (state is LoadingSuppliers)
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 210, 0, 0),
                  child: LoadingBouncingGrid.square(),
                ),
              if (state is LoadedSuppliers)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.27,
                      child: TableView(
                        list: state.list,
                      )),
                ),
            ],
          );
        }),
      ),
    );
  }
}

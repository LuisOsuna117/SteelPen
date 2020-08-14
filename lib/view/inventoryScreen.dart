import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/components/recyclable/tableView.dart';
import 'package:steelpen/logic/inventory/inventory_bloc.dart';

class InventoryScreen extends StatefulWidget {
  @override
  _InventoryScreenState createState() => _InventoryScreenState();
}

class _InventoryScreenState extends State<InventoryScreen> {
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
      body: BlocListener<InventoryBloc, InventoryState>(
        listener: (context, state) {},
        child: BlocBuilder<InventoryBloc, InventoryState>(
          builder: (BuildContext context, state) {
            if (state is InventoryInitial) {
              BlocProvider.of<InventoryBloc>(context).add(LoadInventory());
            }
            return ListView(
              children: <Widget>[
                Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                  child: Text(
                    "Inventario",
                    style: TextStyle(
                        color: Colors.lightBlue,
                        fontSize: 24,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                  child: Text(
                    'Lista de material',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                ),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 0, 0, 0),
                      child: Text(
                        'Producto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                    Text('Cantidad',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 28,
                    ),
                    Text('Actualización',
                        style: TextStyle(fontWeight: FontWeight.bold))
                  ],
                ),
                if (state is LoadingInventory)
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 210, 0, 0),
                    child: LoadingBouncingGrid.square(),
                  ),
                if (state is LoadedInventory)
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: MediaQuery.of(context).size.height,
                        child: TableView(
                          list: state.list,
                        )),
                  ),
              ],
            );
          },
        ),
      ),
    );
  }
}

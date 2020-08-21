import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steelpen/logic/client/client_bloc.dart';
import 'package:steelpen/logic/client/client_logic.dart';
import 'package:steelpen/logic/inventory/inventory_bloc.dart';
import 'package:steelpen/logic/inventory/inventory_logic.dart';
import 'package:steelpen/logic/purchases/purchases_bloc.dart';
import 'package:steelpen/logic/purchases/purchases_logic.dart';
import 'package:steelpen/logic/sales/sales_bloc.dart';
import 'package:steelpen/logic/sales/sales_logic.dart';
import 'package:steelpen/logic/supplier/supplier_bloc.dart';
import 'package:steelpen/logic/supplier/supplier_logic.dart';
import 'package:steelpen/logic/user/user_bloc.dart';
import 'package:steelpen/logic/user/user_logic.dart';
import 'package:steelpen/view/ClientScreen.dart';
import 'package:steelpen/view/homePage.dart';
import 'package:steelpen/view/inventoryScreen.dart';
import 'package:steelpen/view/purchasesScreen.dart';
import 'package:steelpen/view/saleScreen.dart';
import 'package:steelpen/view/supplierScreen.dart';
import 'package:steelpen/view/userScreen.dart';

class CustomDrawer extends StatefulWidget {
  final GestureTapCallback onTap;

  CustomDrawer({this.onTap});

  @override
  _CustomDrawerState createState() => _CustomDrawerState(function: onTap);
}

class _CustomDrawerState extends State<CustomDrawer> {
  GestureTapCallback function = () {};

  _CustomDrawerState({@required this.function});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          _createHeader(),
          _createDrawerItem(
              icon: Icons.home,
              text: 'Inicio',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()));
              }),
          _createDrawerItem(
              icon: Icons.shopping_cart,
              text: 'Compras',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider(
                          create: (_) => PurchasesBloc(logic: MainLogic()),
                          child: PurchasesScreen(),
                        )));
              }),
          _createDrawerItem(
            icon: Icons.store,
            text: 'Ventas',
            onTap: (){
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (BuildContext context) =>
                      BlocProvider(
                        create: (_) => SalesBloc(logic: SaLogic()),
                        child: SaleScreen(),
                      )));
            }
          ),
          Divider(),
          _createDrawerItem(
              icon: Icons.account_box, text: 'Clientes', onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) =>
                    BlocProvider(
                      create: (_) => ClientBloc(logic: CLogic()),
                      child: ClientScreen(),
                    )));
          }),
          _createDrawerItem(
              icon: Icons.person,
              text: 'Proveedores',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider(
                          create: (_) => SupplierBloc(logic: SLogic()),
                          child: SupplierScreen(),
                        )));
              }),
          _createDrawerItem(
              icon: Icons.people,
              text: 'Empleados',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider(
                          create: (_) => UserBloc(logic: ULogic()),
                          child: UserScreen(),
                        )));
              }
          ),
          _createDrawerItem(
              icon: Icons.storage,
              text: 'Inventario',
              onTap: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (BuildContext context) =>
                        BlocProvider(
                          create: (_) => InventoryBloc(logic: ILogic()),
                          child: InventoryScreen(),
                        )));
              }),
          Divider(),
          _createDrawerItem(icon: Icons.exit_to_app, text: 'Cerrar sesión'),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return UserAccountsDrawerHeader(
    accountEmail: Text('marioosunam123@hotmail.com'),
    accountName: Text(
      "Mario Osuna Moreno",
      style: TextStyle(fontSize: 18),
    ),
    currentAccountPicture: CircleAvatar(
      backgroundImage: NetworkImage(
          'https://www.kindpng.com/picc/m/33-338711_circle-user-icon-blue-hd-png-download.png'),
    ),
  );
}

Widget _createDrawerItem(
    {IconData icon, String text, GestureTapCallback onTap}) {
  return ListTile(
    title: Row(
      children: <Widget>[
        Icon(icon),
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(text),
        )
      ],
    ),
    onTap: onTap,
  );
}

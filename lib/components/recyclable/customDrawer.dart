import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

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
          ),
          _createDrawerItem(
            icon: Icons.shopping_cart,
            text: 'Compras',
          ),
          _createDrawerItem(
            icon: Icons.store,
            text: 'Ventas',
          ),
          Divider(),
          _createDrawerItem(icon: Icons.person, text: 'Proveedores'),
          _createDrawerItem(icon: Icons.people, text: 'Empleados'),
          _createDrawerItem(icon: Icons.storage, text: 'Inventario'),
          Divider(),
          _createDrawerItem(icon: Icons.exit_to_app, text: 'Cerrar sesión'),
        ],
      ),
    );
  }
}

Widget _createHeader() {
  return UserAccountsDrawerHeader(accountEmail: Text('marioosunam123@hotmail.com'),
    accountName: Text("Mario Osuna Moreno",style: TextStyle(fontSize: 18),),
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

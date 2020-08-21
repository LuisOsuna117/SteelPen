import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:steelpen/model/Client.dart';
import 'package:steelpen/model/Product.dart';
import 'package:steelpen/model/Purchases.dart';
import 'package:steelpen/model/Supplier.dart';
import 'package:steelpen/model/User.dart';

class TableView extends StatefulWidget {
  final List<dynamic> list;

  TableView({this.list});

  @override
  _TableViewState createState() => _TableViewState();
}

class _TableViewState extends State<TableView> {
  @override
  Widget build(BuildContext context) {
    if (widget.list is List<Purchase>) {
      return ListView.builder(
        shrinkWrap: true,
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ExpansionTile(
              title: Text('#'
                  '${widget.list[index].purchaseId} ${widget.list[index].supplierName}'),
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: <Widget>[
                      Text(
                        'Producto',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 2.5,
                      ),
                      Text('Cantidad',
                          style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(
                        width: MediaQuery.of(context).size.width / 10,
                      ),
                      Text('Precio',
                          style: TextStyle(fontWeight: FontWeight.bold))
                    ],
                  ),
                ),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.list[index].list.length,
                    physics: ClampingScrollPhysics(),
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width / 1.8,
                                child:
                                    Text('${widget.list[index].list[i].name}')),
                            Container(
                                width: MediaQuery.of(context).size.width / 6.8,
                                child: Center(
                                    child: Text(
                                        '${widget.list[index].list[i].quantity}'))),
                            Container(
                                width: MediaQuery.of(context).size.width / 5.3,
                                child: Text(
                                  '${widget.list[index].list[i].price}',
                                  textAlign: TextAlign.right,
                                ))
                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Total: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('${widget.list[index].total}')
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Fecha de compra: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('${widget.list[index].date}')
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        },
      );
    } else if (widget.list is List<Product>) {
      return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: Row(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(8, 14, 0, 0),
                  child: Container(
                      height: 30,
                      width: MediaQuery.of(context).size.width / 1.8,
                      child: Text('${widget.list[index].name}')),
                ),
                Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 7,
                    child:
                        Center(child: Text('${widget.list[index].quantity}'))),
                Container(
                    height: 30,
                    width: MediaQuery.of(context).size.width / 5.3,
                    child: Center(
                      child: Text(
                        widget.list[index].lastPurchase.substring(0, 10),
                        textAlign: TextAlign.right,
                      ),
                    ))
              ],
            ),
          );
        },
      );
    } else if (widget.list is List<Supplier> || widget.list is List<Client>) {
      return ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Stack(
                children: <Widget>[
                  Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331257_1280.png'),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(110, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Nombre: ' + widget.list[index].name),
                        Text('Telefono: ' + widget.list[index].phone),
                        Text('Correo: ' + widget.list[index].email),
                        Text('Dirección: '),
                        Text(
                            "${widget.list[index].street}, ${widget.list[index].suburb}, ${widget.list[index].city}")
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    } else if (widget.list is List<User>) {
      return ListView.builder(
          itemCount: widget.list.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Stack(
                children: <Widget>[
                  Image(
                    image: NetworkImage(
                        'https://cdn.pixabay.com/photo/2018/04/18/18/56/user-3331257_1280.png'),
                    height: 100,
                    width: 100,
                    fit: BoxFit.cover,
                  ),
                  Padding(
                    padding: EdgeInsets.fromLTRB(110, 10, 0, 10),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Nombre: ' + widget.list[index].name),
                        Text('Telefono: ' + widget.list[index].phone),
                        Text('Correo: ' + widget.list[index].email),
                        Text('Dirección: '),
                        Text(
                            "${widget.list[index].street}, ${widget.list[index].suburb}, ${widget.list[index].city}")
                      ],
                    ),
                  ),
                ],
              ),
            );
          });
    } else {
      return ListView.builder(
        itemCount: widget.list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
            child: ExpansionTile(
              title: Text('#'
                  '${widget.list[index].saleId} ${widget.list[index].saleName}'),
              children: <Widget>[
                Text(
                  'Descripcion:',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(widget.list[index].saleDesc),
                Row(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cliente: ",
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                    Text(widget.list[index].clientName),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Text(
                              'Producto',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: <Widget>[
                            Text(
                              'Cantidad',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            )
                          ],
                        )
                      ],
                    )),
                Container(
                  height: 100,
                  child: ListView.builder(
                    itemCount: widget.list[index].list.length,
                    itemBuilder: (BuildContext context, int i) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Container(
                                width: MediaQuery.of(context).size.width / 1.35,
                                child:
                                    Text('${widget.list[index].list[i].name}')),
                            Container(
                                width: MediaQuery.of(context).size.width / 6.8,
                                child: Center(
                                    child: Text(
                                        '${widget.list[index].list[i].quantity}'))),

                          ],
                        ),
                      );
                    },
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: <Widget>[
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: <Widget>[
                              Text('Total: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('${widget.list[index].saleTotal}')
                            ],
                          ),
                        ),
                        Container(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              Text('Fecha de compra: ',
                                  style:
                                      TextStyle(fontWeight: FontWeight.bold)),
                              Text('${widget.list[index].saleDate}')
                            ],
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          );
        },
      );
    }
  }
}

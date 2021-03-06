import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/components/recyclable/tableView.dart';
import 'package:steelpen/logic/purchases/purchases_bloc.dart';
import 'package:steelpen/logic/purchases/purchases_logic.dart';

class PurchasesScreen extends StatefulWidget {
  @override
  _PurchasesScreenState createState() => _PurchasesScreenState();
}

class _PurchasesScreenState extends State<PurchasesScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      drawer: CustomDrawer(),
      body: BlocListener<PurchasesBloc, PurchasesState>(
        listener: (context, state) {
          if (state is RefreshPurchases) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                      create: (_) => PurchasesBloc(logic: MainLogic()),
                      child: PurchasesScreen(),
                    )));
          }
        },
        child: BlocBuilder<PurchasesBloc, PurchasesState>(
            builder: (BuildContext context, state) {
          if (state is PurchasesInitial) {
            BlocProvider.of<PurchasesBloc>(context).add(LoadPurchases());
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
                          "Compras",
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
                          onPressed: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (BuildContext context) => BlocProvider(
                                      create: (_) =>
                                          PurchasesBloc(logic: MainLogic()),
                                      child: AddPurchaseScreen(),
                                    )));
                          },
                          color: Colors.lightBlue,
                          iconSize: 26,
                        ),
                      )
                    ],
                  )
                ],
              ),
              if (state is LoadingPurchases)
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 210, 0, 0),
                  child: LoadingBouncingGrid.square(),
                ),
              if (state is LoadedPurchases)
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height / 1.27,
                      child: TableView(
                        list: state.list,
                      )),
                )
            ],
          );
        }),
      ),
    );
  }
}

class AddPurchaseScreen extends StatefulWidget {
  @override
  _AddPurchaseScreenState createState() => _AddPurchaseScreenState();
}

class _AddPurchaseScreenState extends State<AddPurchaseScreen> {
  TextEditingController supplier;
  TextEditingController product;
  TextEditingController quantity;
  TextEditingController price;

  double purchaseTotal = 0.0;

  @override
  void initState() {
    super.initState();
    supplier = TextEditingController();
    product = TextEditingController();
    quantity = TextEditingController();
    price = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> listProducts = [];
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.lightBlue),
      ),
      drawer: CustomDrawer(),
      body: BlocListener<PurchasesBloc, PurchasesState>(
        listener: (context, state) {
          if (state is RefreshPurchases) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                      create: (_) => PurchasesBloc(logic: MainLogic()),
                      child: PurchasesScreen(),
                    )));
          }
        },
        child: BlocBuilder<PurchasesBloc, PurchasesState>(
            builder: (BuildContext context, state) {
          if (state is AddedProducts) {
            listProducts = state.map;
            print(listProducts);
            purchaseTotal = state.total;
            print(purchaseTotal);
          }
          return ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "Agregar Compra",
                      style: TextStyle(
                          color: Colors.lightBlue,
                          fontSize: 24,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.115,
                        child: TextField(
                          controller: supplier,
                          decoration: InputDecoration(labelText: 'Proveedor'),
                        )),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Añadir producto a la compra',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    ),
                  ],
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.63,
                        child: TextField(
                          controller: product,
                          decoration: InputDecoration(labelText: 'Producto'),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
                    child: Container(
                        width: 100,
                        child: TextField(
                          controller: quantity,
                          decoration: InputDecoration(labelText: 'Cantidad'),
                        )),
                  )
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.115,
                        child: TextField(
                          controller: price,
                          decoration:
                              InputDecoration(labelText: 'Precio individual'),
                        )),
                  ),
                ],
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FlatButton(
                  onPressed: () {
                    var tmp = {
                      "pname": product.text,
                      "pquantity": int.parse(quantity.text),
                      "pprice": double.parse(price.text)
                    };
                    BlocProvider.of<PurchasesBloc>(context)
                        .add(AddProduct(map: listProducts, product: tmp));
                    product.text = '';
                    quantity.text = '';
                    price.text = '';
                  },
                  child: Center(
                      child: Text(
                    'Agregar Producto',
                    style: TextStyle(color: Colors.white),
                  )),
                  color: Colors.lightBlueAccent,
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: Row(
                  children: <Widget>[
                    Text(
                      'Producto',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 2.5,
                    ),
                    Text(
                      'Cantidad',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width / 12,
                    ),
                    Text(
                      'Precio',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
              if (state is AddedProducts)
                Column(
                  children: <Widget>[
                    Container(
                      height: 270,
                      child: ListView.builder(
                          itemCount: state.map.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Card(
                              child: Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: <Widget>[
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                1.85,
                                        child: Text(
                                            "${listProducts[index]['pname']}")),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                8,
                                        child: Center(
                                            child: Text(
                                                "${listProducts[index]['pquantity']}"))),
                                    Container(
                                        width:
                                            MediaQuery.of(context).size.width /
                                                5,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: <Widget>[
                                            Text(
                                                "${listProducts[index]['pprice']}"),
                                          ],
                                        ))
                                  ],
                                ),
                              ),
                            );
                          }),
                      color: Colors.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Total: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("\$ $purchaseTotal")
                        ],
                      ),
                    ),
                  ],
                ),
              if (state is PurchasesInitial)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 270,
                      width: MediaQuery.of(context).size.width,
                      child: Center(child: Text("No ha agregado ningun producto aun.")),
                      color: Colors.black12,
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: <Widget>[
                          Text("Total: ",
                              style: TextStyle(fontWeight: FontWeight.bold)),
                          Text("\$ $purchaseTotal")
                        ],
                      ),
                    ),
                  ],
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FlatButton(
                  onPressed: () {
                    if (supplier.text.isNotEmpty) {
                      var p = {
                        "sname": supplier.text,
                        "ptotal": purchaseTotal,
                        "products": listProducts
                      };
                      print(p);
                      BlocProvider.of<PurchasesBloc>(context)
                          .add(AddPurchase(map: p));
                    }
                  },
                  child: Center(
                      child: Text(
                    'Agregar compra',
                    style: TextStyle(color: Colors.white),
                  )),
                  color: Colors.lightBlue,
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}

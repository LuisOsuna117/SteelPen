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
  TextEditingController supplier;
  TextEditingController total;
  TextEditingController product;
  TextEditingController quantity;
  TextEditingController price;

  @override
  void initState() {
    super.initState();
    supplier = TextEditingController();
    total = TextEditingController();
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
          if(state is RefreshPurchases){
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
          return ListView(
            children: <Widget>[
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 24, horizontal: 20),
                child: Text(
                  "Compras",
                  style: TextStyle(
                      color: Colors.lightBlue,
                      fontSize: 24,
                      fontWeight: FontWeight.bold),
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                child: Text(
                  'Añadir Compra',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: 140,
                        child: TextField(
                          controller: supplier,
                          decoration: InputDecoration(labelText: 'Proveedor'),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                  Container(
                      width: 140,
                      child: TextField(
                        controller: total,
                        decoration: InputDecoration(labelText: 'Total'),
                      ))
                ],
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Text(
                  'Añadir producto a la compra',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: 140,
                        child: TextField(
                          controller: product,
                          decoration: InputDecoration(labelText: 'Producto'),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7,
                  ),
                  Container(
                      width: 140,
                      child: TextField(
                        controller: quantity,
                        decoration: InputDecoration(labelText: 'Cantidad'),
                      ))
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: 140,
                        child: TextField(
                          controller: price,
                          decoration:
                              InputDecoration(labelText: 'Precio individual'),
                        )),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width / 7.5,
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                    child: Container(
                      width: 150,
                      child: FlatButton(
                        onPressed: () {
                          var tmp = {
                            "pname": product.text,
                            "pquantity": int.parse(quantity.text),
                            "pprice": double.parse(price.text)
                          };
                          listProducts.add(tmp);
                          listProducts.forEach((e) => print(e));
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
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 30, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: <Widget>[
                    FlatButton(
                      child: Text(
                        'Agregar compra',
                        style: TextStyle(color: Colors.white),
                      ),
                      onPressed: () {
                        if (supplier.text.isNotEmpty) {
                          if (product.text.isNotEmpty) {
                            var tmp = {
                              "pname": product.text,
                              "pquantity": quantity.text,
                              "pprice": price.text
                            };
                            listProducts.add(tmp);
                          }
                          var p = {
                            "sname": supplier.text,
                            "ptotal": total.text,
                            "products": listProducts
                          };
                          print(p);
                          BlocProvider.of<PurchasesBloc>(context)
                              .add(AddPurchase(map: p));
                        }
                      },
                      color: Colors.lightBlue,
                    )
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 0, 10),
                child: Text(
                  'Lista de compras',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                ),
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
                      height: MediaQuery.of(context).size.height,
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

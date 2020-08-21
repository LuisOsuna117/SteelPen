import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/components/recyclable/tableView.dart';
import 'package:steelpen/logic/sales/sales_bloc.dart';
import 'package:steelpen/logic/sales/sales_logic.dart';

class SaleScreen extends StatefulWidget {
  @override
  _SaleScreenState createState() => _SaleScreenState();
}

class _SaleScreenState extends State<SaleScreen> {
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
      body: BlocListener<SalesBloc, SalesState>(
        listener: (context, state) {},
        child: BlocBuilder<SalesBloc, SalesState>(
          builder: (BuildContext context, state) {
            if (state is SalesInitial) {
              BlocProvider.of<SalesBloc>(context).add(LoadSales());
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
                            "Ventas",
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
                                  builder: (BuildContext context) =>
                                      BlocProvider(
                                        create: (_) =>
                                            SalesBloc(logic: SaLogic()),
                                        child: AddSaleScreen(),
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
                if (state is LoadingSales)
                  Padding(
                    padding: EdgeInsets.fromLTRB(0, 210, 0, 0),
                    child: LoadingBouncingGrid.square(),
                  ),
                if (state is LoadedSales)
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
          },
        ),
      ),
    );
  }
}

class AddSaleScreen extends StatefulWidget {
  @override
  _AddSaleScreenState createState() => _AddSaleScreenState();
}

class _AddSaleScreenState extends State<AddSaleScreen> {
  TextEditingController sale;
  TextEditingController client;
  TextEditingController description;
  TextEditingController product;
  TextEditingController total;
  TextEditingController quantity;

  @override
  void initState() {
    super.initState();
    sale = TextEditingController();
    product = TextEditingController();
    quantity = TextEditingController();
    client = TextEditingController();
    total = TextEditingController();
    description = TextEditingController();
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
      body: BlocListener<SalesBloc, SalesState>(
        listener: (context, state) {
          if (state is RefreshSales) {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => BlocProvider(
                      create: (_) => SalesBloc(logic: SaLogic()),
                      child: SaleScreen(),
                    )));
          }
        },
        child: BlocBuilder<SalesBloc, SalesState>(
            builder: (BuildContext context, state) {
          if (state is AddedProducts) {
            listProducts = state.map;
            print(listProducts);
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
                      "Agregar Venta",
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
                          controller: client,
                          decoration: InputDecoration(labelText: 'Cliente'),
                        )),
                  ),
                ],
              ),
              Row(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 0, 0, 0),
                    child: Container(
                        width: MediaQuery.of(context).size.width / 1.63,
                        child: TextField(
                          controller: sale,
                          decoration:
                              InputDecoration(labelText: 'Nombre de la venta'),
                        )),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      width: 100,
                      child: TextField(
                        controller: total,
                        decoration: InputDecoration(labelText: 'Total'),
                      ),
                    ),
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Card(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextField(
                        controller: description,
                        maxLines: 4,
                        decoration: InputDecoration.collapsed(
                            hintText: "Descripción de la venta"),
                      ),
                    )),
              ),
              Padding(
                padding: EdgeInsets.fromLTRB(20, 10, 0, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Material usado',
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
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FlatButton(
                  onPressed: () {
                    var tmp = {
                      "pname": product.text,
                      "pquantity": int.parse(quantity.text),
                    };
                    BlocProvider.of<SalesBloc>(context)
                        .add(AddProduct(map: listProducts, product: tmp));
                    product.text = '';
                    quantity.text = '';
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
                  ],
                ),
              ),
              if (state is AddedProducts)
                Column(
                  children: <Widget>[
                    Container(
                      height: 180,
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
                                  ],
                                ),
                              ),
                            );
                          }),
                      color: Colors.black12,
                    ),
                  ],
                ),
              if (state is SalesInitial)
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Container(
                      height: 180,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                          child: Text("No ha agregado ningun producto aun.")),
                      color: Colors.black12,
                    ),
                  ],
                ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: FlatButton(
                  onPressed: () {
                    if (client.text.isNotEmpty) {
                      var p = {
                        "sname": sale.text,
                        "desc": description.text,
                        "total": double.parse(total.text),
                        "cname": client.text,
                        "products": listProducts
                      };
                      print(p);
                      BlocProvider.of<SalesBloc>(context)
                          .add(AddSale(map: p));
                    }
                  },
                  child: Center(
                      child: Text(
                    'Agregar venta',
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

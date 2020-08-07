import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steelpen/components/line_chart/points.dart';
import 'package:steelpen/components/line_chart/stacked_area.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/logic/home/home_bloc.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextStyle mainStyle = TextStyle(
      color: Colors.lightBlue, fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle badStyle = TextStyle(
      color: Colors.redAccent, fontSize: 24, fontWeight: FontWeight.bold);
  TextStyle goodStyle = TextStyle(
      color: Colors.green, fontSize: 24, fontWeight: FontWeight.bold);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeBloc(),
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(color: Colors.lightBlue),
        ),
        drawer: CustomDrawer(),
        body: BlocListener<HomeBloc, HomeState>(
          listener: (context, state) {},
          child: BlocBuilder<HomeBloc, HomeState>(
            builder: (BuildContext context, state) {
              return ListView(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.fromLTRB(20, 20, 0, 30),
                    child: Text(
                      'Inicio',
                      style: mainStyle,
                    ),
                  ),
                  Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: <Widget>[
                          Text(
                            'Ingresos',
                            style: goodStyle,
                          ),
                          Text(
                            '/',
                            style: TextStyle(fontSize: 24),
                          ),
                          Text(
                            'Egresos',
                            style: badStyle,
                          )
                        ],
                      )),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: StackedAreaLineChart.withSampleData(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Ventas',
                      style: mainStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: PointsLineChart.withRandomData(),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Text(
                      'Compras',
                      style: mainStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 4,
                      child: PointsLineChart.withRandomData(),
                    ),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}

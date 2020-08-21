import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:steelpen/components/recyclable/customDrawer.dart';
import 'package:steelpen/components/recyclable/tableView.dart';
import 'package:steelpen/logic/user/user_bloc.dart';

class UserScreen extends StatefulWidget {
  @override
  _UserScreenState createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
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
      body: BlocListener<UserBloc, UserState>(
        listener: (context, state) {},
        child: BlocBuilder<UserBloc, UserState>(
            builder: (BuildContext context, state) {
          if (state is UserInitial) {
            BlocProvider.of<UserBloc>(context).add(LoadUsers());
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
                          "Empleados",
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
              if (state is LoadingUsers)
                Padding(
                  padding: EdgeInsets.fromLTRB(0, 210, 0, 0),
                  child: LoadingBouncingGrid.square(),
                ),
              if (state is LoadedUsers)
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

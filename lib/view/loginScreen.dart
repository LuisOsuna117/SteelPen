import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:steelpen/logic/login/login_bloc.dart';
import 'package:steelpen/view/homePage.dart';

//import 'package:steelpen/logic/login/login_bloc.dart';
class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController user;
  TextEditingController pass;
  TextStyle textStyle =
      TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold);

  @override
  void initState() {
    super.initState();
    user = TextEditingController();
    pass = TextEditingController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<LoginBloc, LoginState>(
        listener: (context, state) {
          if (state is ErrorState) {
            _showError(context, state.message);
          }
          if (state is LoggedInState) {
            Navigator.of(context).pushAndRemoveUntil(
                MaterialPageRoute(
                    builder: (BuildContext context) => HomePage()),
                (Route<dynamic> route) => false);
          }
        },
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (BuildContext context, state) {
            return ListView(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.fromLTRB(16.0, 100.0, 16.0, 16.0),
                  child: Container(
                    height: MediaQuery.of(context).size.height / 2.8,
                    child: Center(
                      child: Image.asset('assets/images/logo.png'),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.fromLTRB(16.0, 34.0, 16.0, 0),
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20.0),
                        child: TextField(
                          controller: user,
                          decoration: InputDecoration(
                              labelText: 'Usuario', icon: Icon(Icons.person)),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 20.0),
                        child: TextField(
                          controller: pass,
                          obscureText: true,
                          decoration: InputDecoration(
                              labelText: 'Contraseña', icon: Icon(Icons.https)),
                        ),
                      ),
                      if (state is LogginInState)
                        Padding(
                          padding: EdgeInsets.all(20),
                          child: CircularProgressIndicator(),
                        )
                      else
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20.0),
                          child: FlatButton(
                            color: Colors.lightBlue,
                            onPressed: _doLogin,
                            child: Text(
                              'Iniciar sesión',
                              style: textStyle,
                            ),
                            padding: EdgeInsets.symmetric(
                                vertical: 20.0,
                                horizontal:
                                    MediaQuery.of(context).size.width / 3),
                          ),
                        )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _doLogin() {
    BlocProvider.of<LoginBloc>(context).add(DoLoginEvent(user.text, pass.text));
  }

  void _showError(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(message),
    ));
  }
}

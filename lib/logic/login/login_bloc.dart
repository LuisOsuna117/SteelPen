import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'login_logic.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginLogic logic;

  LoginBloc({@required this.logic}) : super(LoginInitial());

  @override
  Stream<LoginState> mapEventToState(
    LoginEvent event,
  ) async* {
    if(event is DoLoginEvent){
      yield LogginInState();

      try{
        await Future.delayed(Duration(seconds: 1));
        dynamic token = await logic.login(event.user,event.password);
        yield LoggedInState(token);
      } on LoginException{
        yield ErrorState("No pudo iniciar sesion.");
      }
    }
  }
}

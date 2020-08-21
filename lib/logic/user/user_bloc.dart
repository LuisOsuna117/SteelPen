import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steelpen/logic/user/user_logic.dart';
import 'package:steelpen/model/User.dart';

part 'user_event.dart';
part 'user_state.dart';

class UserBloc extends Bloc<UserEvent, UserState> {
  final UserLogic logic;
  UserBloc({this.logic}) : super(UserInitial());

  @override
  Stream<UserState> mapEventToState(
    UserEvent event,
  ) async* {
    if (event is LoadUsers){
      yield LoadingUsers();
      try{
        await Future.delayed(Duration(seconds: 2));
        List<User> result = await logic.loadUsers();
        yield LoadedUsers(list: result);
      }on UserException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
  }
}

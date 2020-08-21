import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steelpen/logic/client/client_logic.dart';
import 'package:steelpen/model/Client.dart';

part 'client_event.dart';
part 'client_state.dart';

class ClientBloc extends Bloc<ClientEvent, ClientState> {
  final ClientLogic logic;
  ClientBloc({this.logic}) : super(ClientInitial());

  @override
  Stream<ClientState> mapEventToState(
    ClientEvent event,
  ) async* {
    if(event is LoadClients){
      yield LoadingClients();
      try{
        await Future.delayed(Duration(seconds: 2));
        List<Client> result = await logic.loadClients();
        yield LoadedClients(list: result);
      }on ClientException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
  }
}

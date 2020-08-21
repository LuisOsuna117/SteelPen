part of 'client_bloc.dart';

abstract class ClientState extends Equatable {
  const ClientState();
}

class ClientInitial extends ClientState {
  @override
  List<Object> get props => [];
}

class LoadingClients extends ClientState{
  @override
  List<Object> get props => [];

}

class LoadedClients extends ClientState{
  final List<Client> list;
  LoadedClients({this.list});

  @override
  List<Object> get props => [list];

}

class ErrorState extends ClientState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}

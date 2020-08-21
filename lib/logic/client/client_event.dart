part of 'client_bloc.dart';

abstract class ClientEvent extends Equatable {
  const ClientEvent();
}

class LoadClients extends ClientEvent{
  @override
  List<Object> get props => [];

}
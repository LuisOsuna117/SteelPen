part of 'sales_bloc.dart';

abstract class SalesState extends Equatable {
  const SalesState();
}

class SalesInitial extends SalesState {
  @override
  List<Object> get props => [];
}

class LoadingSales extends SalesState{
  @override
  List<Object> get props => [];

}

class LoadedSales extends SalesState{
  final List<Sale> list;

  LoadedSales({this.list});

  @override
  List<Object> get props => [list];

}

class AddedProducts extends SalesState{
  final List<dynamic> map;
  final int total;

  AddedProducts({this.map,this.total});

  @override
  List<Object> get props => [map,total];

}

class RefreshSales extends SalesState{
  @override
  List<Object> get props => [];

}

class ErrorState extends SalesState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
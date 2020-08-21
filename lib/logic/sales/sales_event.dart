part of 'sales_bloc.dart';

abstract class SalesEvent extends Equatable {
  const SalesEvent();
}

class LoadSales extends SalesEvent{
  @override
  List<Object> get props => [];

}

class AddSale extends SalesEvent{
  final dynamic map;

  AddSale({this.map});

  @override
  List<Object> get props => [map];

}

class AddProduct extends SalesEvent{
  final List<dynamic> map;
  final dynamic product;

  AddProduct({this.map,this.product});

  @override
  List<Object> get props => [map,product];

}
part of 'purchases_bloc.dart';

abstract class PurchasesEvent extends Equatable {
  const PurchasesEvent();
}
class LoadForm extends PurchasesEvent{

  @override
  List<Object> get props => [];

}
class LoadPurchases extends PurchasesEvent{

  @override
  List<Object> get props => [];

}

class AddPurchase extends PurchasesEvent{
  final dynamic map;

  AddPurchase({this.map});

  @override
  List<Object> get props => [map];

}

class AddProduct extends PurchasesEvent{
  final List<dynamic> map;
  final dynamic product;

  AddProduct({this.map,this.product});

  @override
  List<Object> get props => [map,product];

}

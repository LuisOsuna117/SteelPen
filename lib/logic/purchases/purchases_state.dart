part of 'purchases_bloc.dart';

abstract class PurchasesState extends Equatable {
  const PurchasesState();
}

class PurchasesInitial extends PurchasesState {
  @override
  List<Object> get props => [];
}

class LoadingPurchases extends PurchasesState{
  @override
  List<Object> get props => [];

}

class LoadedPurchases extends PurchasesState{
  final List<Purchase> list;

  LoadedPurchases({this.list});
  @override
  List<Object> get props => [list];

}

class LoadedForm extends PurchasesState{
  final List<Purchase> list;

  LoadedForm({this.list});
  @override
  List<Object> get props => [list];

}

class RefreshPurchases extends PurchasesState{
  @override
  List<Object> get props => [];

}

class AddedProducts extends PurchasesState{
  final List<dynamic> map;
  final double total;

  AddedProducts({this.map,this.total});

  @override
  List<Object> get props => [map,total];

}

class ErrorState extends PurchasesState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}

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
  // TODO: implement props
  List<Object> get props => [];

}

class ErrorState extends PurchasesState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}

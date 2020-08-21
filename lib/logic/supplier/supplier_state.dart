part of 'supplier_bloc.dart';

abstract class SupplierState extends Equatable {
  const SupplierState();
}

class SupplierInitial extends SupplierState {
  @override
  List<Object> get props => [];
}

class LoadingSuppliers extends SupplierState{
  @override
  List<Object> get props => [];

}

class LoadedSuppliers extends SupplierState{
  final List<Supplier> list;

  LoadedSuppliers({this.list});

  @override
  List<Object> get props => [list];

}

class ErrorState extends SupplierState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
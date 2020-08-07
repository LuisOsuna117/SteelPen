part of 'purchases_bloc.dart';

abstract class PurchasesState extends Equatable {
  const PurchasesState();
}

class PurchasesInitial extends PurchasesState {
  @override
  List<Object> get props => [];
}

part of 'inventory_bloc.dart';

abstract class InventoryState extends Equatable {
  const InventoryState();
}

class InventoryInitial extends InventoryState {
  @override
  List<Object> get props => [];
}

class LoadingInventory extends InventoryState{

  @override
  List<Object> get props => [];


}
class LoadedInventory extends InventoryState{
  final List<Product> list;

  LoadedInventory({this.list});
  @override
  List<Object> get props => [list];

}

class ErrorState extends InventoryState{
  final String message;

  ErrorState(this.message);
  @override
  List<Object> get props => [message];
}
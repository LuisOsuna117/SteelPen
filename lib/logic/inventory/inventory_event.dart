part of 'inventory_bloc.dart';

abstract class InventoryEvent extends Equatable {
  const InventoryEvent();
}

class LoadInventory extends InventoryEvent{

  @override
  List<Object> get props => [];

}
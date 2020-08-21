import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steelpen/logic/inventory/inventory_logic.dart';
import 'package:steelpen/model/Product.dart';

part 'inventory_event.dart';
part 'inventory_state.dart';

class InventoryBloc extends Bloc<InventoryEvent, InventoryState> {
  final InventoryLogic logic;
  InventoryBloc({this.logic}) : super(InventoryInitial());

  @override
  Stream<InventoryState> mapEventToState(
    InventoryEvent event,
  ) async* {
    if (event is LoadInventory){
      yield LoadingInventory();
      try{
        await Future.delayed(Duration(seconds: 2));
        List<Product> result = await logic.loadPurchases();
        yield LoadedInventory(list: result);
      }on InventoryException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
  }
}

import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steelpen/logic/supplier/supplier_logic.dart';
import 'package:steelpen/model/Supplier.dart';

part 'supplier_event.dart';
part 'supplier_state.dart';

class SupplierBloc extends Bloc<SupplierEvent, SupplierState> {
  final SupplierLogic logic;
  SupplierBloc({this.logic}) : super(SupplierInitial());

  @override
  Stream<SupplierState> mapEventToState(
    SupplierEvent event,
  ) async* {
    if (event is LoadSuppliers){
      yield LoadingSuppliers();
      try{
        await Future.delayed(Duration(seconds: 2));
        List<Supplier> result = await logic.loadSuppliers();
        yield LoadedSuppliers(list: result);
      }on SupplierException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
  }
}

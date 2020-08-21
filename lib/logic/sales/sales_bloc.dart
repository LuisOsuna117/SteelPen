import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:steelpen/logic/sales/sales_logic.dart';
import 'package:steelpen/model/Sales.dart';

part 'sales_event.dart';
part 'sales_state.dart';

class SalesBloc extends Bloc<SalesEvent, SalesState> {
  final SalesLogic logic;
  SalesBloc({this.logic}) : super(SalesInitial());

  @override
  Stream<SalesState> mapEventToState(
    SalesEvent event,
  ) async* {
    if(event is LoadSales){
      yield LoadingSales();
      try{
        await Future.delayed(Duration(seconds: 2));
        List<Sale> result = await logic.loadSales();
        yield LoadedSales(list: result);
      }on SalesException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
    if (event is AddProduct){
      List<dynamic> list = event.map;
      list.add(event.product);
      int total = 0;
      list.forEach((e) => total += 1);
      yield AddedProducts(map: list,total: total);
    }
    if (event is AddSale){
      try{
        var result = await logic.addSale(event.map);
        print(result);
        yield RefreshSales();
      }on SalesException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
  }
}

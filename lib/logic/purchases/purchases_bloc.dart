import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:steelpen/logic/purchases/purchases_logic.dart';
import 'package:steelpen/model/Purchases.dart';

part 'purchases_event.dart';
part 'purchases_state.dart';

class PurchasesBloc extends Bloc<PurchasesEvent, PurchasesState> {
  final PurchasesLogic logic;

  PurchasesBloc({@required this.logic}) : super(PurchasesInitial());

  @override
  Stream<PurchasesState> mapEventToState(
    PurchasesEvent event,
  ) async* {
    if(event is LoadPurchases){
      yield LoadingPurchases();
      try{
        await Future.delayed(Duration(seconds: 2));
        List<Purchase> list = await logic.loadPurchases();
        yield LoadedPurchases(list: list);
      } on PurchaseException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
    if(event is AddPurchase){
      try{
        var result = await logic.addPurchase(event.map);
        print(result);
        yield RefreshPurchases();
      }on PurchaseException{
        yield ErrorState("No pudieron cargar los datos.");
      }
    }
    if (event is AddProduct){
      List<dynamic> list = event.map;
      double total = 0.0;
      list.add(event.product);
      list.forEach((p) {
        print(p);
        total += p['pquantity'] * p['pprice'];
      });
      yield AddedProducts(map: list,total: total);
    }
  }
}

import 'dart:convert';

import 'package:steelpen/model/Supplier.dart';
import 'package:http/http.dart' as http;

abstract class SupplierLogic {
  Future<List<Supplier>> loadSuppliers();
}

class SupplierException implements Exception {}

class SLogic extends SupplierLogic{
  @override
  Future<List<Supplier>> loadSuppliers() async{
    List<Supplier> supplierList = [];
    var url = 'http://35.238.5.140:3000/getSuppliers';
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    result.forEach((p) {
      Supplier tmp = new Supplier(
        supplierId: p['supplierid'],
        name: p['sname'],
        email: p['semail'],
        phone: p['sphone'],
        street: p['sstreet'],
        suburb: p['ssuburb'],
        city: p['scity']
      );
      supplierList.add(tmp);
    });
    return supplierList;
  }

}
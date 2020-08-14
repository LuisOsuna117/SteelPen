import 'dart:convert';

import 'package:steelpen/model/Product.dart';
import 'package:http/http.dart' as http;

abstract class InventoryLogic {
  Future<List<Product>> loadPurchases();
}

class InventoryException implements Exception {}

class ILogic extends InventoryLogic{
  @override
  Future<List<Product>> loadPurchases() async {
    List<Product> productList = [];
    var url = 'http://35.238.5.140:3000/getInventory';
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    result.forEach((p) {
      Product tmp = new Product(
          name: p['pname'],
          quantity: p['pquantity'],
          lastPurchase: p['plastpurchase']);
      productList.add(tmp);
    });
    return productList;
  }

}
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:steelpen/model/Product.dart';
import 'package:steelpen/model/Purchases.dart';

abstract class PurchasesLogic {
  Future<List<Purchase>> loadPurchases();

  Future<String> addPurchase(dynamic map);
}

class PurchaseException implements Exception {}

class MainLogic extends PurchasesLogic {
  List<Product> productList = [];
  List<Purchase> list = [];
  int start = 0;

  @override
  Future<List<Purchase>> loadPurchases() async {
    var url = 'http://35.238.5.140:3000/getPurchases';
    var response = await http.get(url);
    var result = json.decode(response.body);

    result.forEach((k) {
      k['products'].forEach((p) {
        Product tmp = new Product(
            name: p['pname'],
            price: p['pprice'].toDouble(),
            quantity: p['pquantity'],
            lastPurchase: p['plastpurchase']);
        productList.add(tmp);
      });

      Purchase temp = new Purchase(
          purchaseId: k['purchaseid'],
          supplierName: k['sname'],
          total: k['ptotal'].toDouble(),
          date: k['pdate'],
          list: productList.sublist(start, start + k['products'].length));
      list.add(temp);
      start += k['products'].length;
    });
    return list;
  }

  @override
  Future<String> addPurchase(dynamic map) async {
    var url = 'http://35.238.5.140:3000/addPurchase';
    HttpClient httpClient = new HttpClient();
    HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
    request.headers.set('content-type', 'application/json');
    request.add(utf8.encode(json.encode(map)));
    HttpClientResponse response = await request.close();
    String reply = await response.transform(utf8.decoder).join();
    httpClient.close();
    print(reply);
    return reply;
  }
}

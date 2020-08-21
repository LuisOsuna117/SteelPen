import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:steelpen/model/Product.dart';
import 'package:steelpen/model/Sales.dart';

abstract class SalesLogic {
  Future<List<Sale>> loadSales();
  Future<String> addSale(dynamic map);
}

class SalesException implements Exception{}

class SaLogic extends SalesLogic {
  @override
  Future<List<Sale>> loadSales() async {
    List<Product> productList = [];
    List<Sale> saleList = [];
    int start = 0;
    var url = 'http://35.238.5.140:3000/getSales';
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    result.forEach((k) {
      k['products'].forEach((p) {
        Product tmp = new Product(name: p['pname'], quantity: p['pquantity']);
        productList.add(tmp);
      });

      Sale temp = new Sale(
          saleId: k['saleid'],
          saleName: k['sname'],
          saleDesc: k['sdesc'],
          saleTotal: k['stotal'].toDouble(),
          clientName: k['cname'],
          saleDate: k['pdate'],
          list: productList.sublist(start, start + k['products'].length));
      saleList.add(temp);
      start += k['products'].length;
    });
    return saleList;
  }

  @override
  Future<String> addSale(dynamic map) async{
    var url = 'http://35.238.5.140:3000/addSale';
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

import 'package:steelpen/model/Product.dart';

class Purchase {
  final int purchaseId;
  final String supplierName;
  final double total;
  final String date;
  final List<Product> list;
  
  Purchase({this.purchaseId,this.supplierName,this.total,this.date,this.list});

}
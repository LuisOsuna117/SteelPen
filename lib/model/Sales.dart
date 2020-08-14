import 'package:steelpen/model/Product.dart';

class Sale {
  final int saleId;
  final String saleName;
  final String saleDesc;
  final double saleTotal;
  final String clientName;
  final String saleDate;
  final List<Product> list;

  Sale(
      {this.saleId,
      this.saleName,
      this.saleDesc,
      this.saleTotal,
      this.saleDate,
      this.clientName,
      this.list});
}

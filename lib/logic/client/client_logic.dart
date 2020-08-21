import 'package:steelpen/model/Client.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class ClientLogic{
  Future<List<Client>> loadClients();
}

class ClientException implements Exception{}

class CLogic extends ClientLogic{
  @override
  Future<List<Client>> loadClients() async{
    List<Client> clientList = [];
    var url = 'http://35.238.5.140:3000/getClients';
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    result.forEach((p) {
      Client tmp = new Client(
          name: p['cname'],
          email: p['cemail'],
          phone: p['cphone'],
          street: p['cstreet'],
          suburb: p['csuburb'],
          city: p['ccity']
      );
      clientList.add(tmp);
    });
    return clientList;
  }

}
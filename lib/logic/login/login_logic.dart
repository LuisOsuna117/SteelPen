import 'dart:convert';
import 'package:http/http.dart' as http;

abstract class LoginLogic {
  Future<String> login(String user, String password);
  Future<String> logout();
}

class LoginException implements Exception {}

class MainLogic extends LoginLogic {
  @override
  Future<String> login(String user, String password) async {
    var url = 'http://35.238.5.140:3000/userLogin';
    var response =
        await http.post(url, body: {'username': user, 'password': password});
    var result = json.decode(response.body);
    if(result[0][0]['result'] != 1){
      throw LoginException();
    }
    return "un token";
  }

  @override
  Future<String> logout() async {
    return "Ha cerrado sesion";
  }
}

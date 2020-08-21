import 'package:steelpen/model/User.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

abstract class UserLogic{
  Future<List<User>> loadUsers();
}

class UserException implements Exception{}

class ULogic extends UserLogic{
  @override
  Future<List<User>> loadUsers() async{
    List<User> userList = [];
    var url = 'http://35.238.5.140:3000/getUsers';
    var response = await http.get(url);
    var result = json.decode(response.body);
    print(result);
    result.forEach((p) {
      User tmp = new User(
          name: "${p['fname']} ${p['lname']}",
          email: p['email'],
          phone: p['cphone'],
          street: p['street'],
          suburb: p['suburb'],
          city: p['city'],
          salary: p['salary'].toDouble()
      );
      userList.add(tmp);
    });
    return userList;
  }

}
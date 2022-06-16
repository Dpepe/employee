import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';

Future<List<Employee>> fetchEmployee() async {
 
  final  postsURL = Uri.parse('http://dummy.restapiexample.com/public/api/v1/employees');
  Response res = await get(
    postsURL
  );
  if (res.statusCode == 200) {
  
    final body = jsonDecode(res.body);

    List<dynamic> bodys = body['data'];
   
    List<Employee> posts = bodys
      .map(
        (dynamic item) => Employee.fromJson(item),
      ).toList();
    return posts;

  } else {
    
    throw "Unable to retrieve employee.";
  }
}
Future<Employee> fetchEmployeeGet(int ids) async {

  final response = await get(Uri.parse('http://dummy.restapiexample.com/api/v1/employee/$ids'));

  if (response.statusCode == 200) {
    // If the server did return a 200 OK response,
    // then parse the JSON.
     final body = jsonDecode(response.body);
     var bodys = body['data']; 
    return Employee.fromJson(bodys);
  } else {
    // If the server did not return a 200 OK response,
    // then throw an exception.
    throw Exception('Failed to load employee');
  }
}


class Employee {
  final dynamic id;
  final dynamic employee_name;
  final dynamic employee_salary;
  final dynamic employee_age;
  final dynamic profile_image;
  const Employee({
    required this.id,
    required this.employee_name,
    required this.employee_salary,
    required this.employee_age,
    required this.profile_image,
  });

  factory Employee.fromJson(Map<String, dynamic> json) {
    return Employee(
      id: json['id'],
      employee_name: json['employee_name'],
      employee_salary: json['employee_salary'],
      employee_age: json['employee_age'],
      profile_image: json['profile_image'],
    );
  }
}
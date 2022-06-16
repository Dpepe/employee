import 'package:flutter/material.dart';
import 'package:flutter_employee/employee/model.dart';
import 'package:http/http.dart';
import 'dart:async';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'provide_employee.dart';
const  imgAndorid = "assets/android_robot.png";


class LoginEnployee extends StatefulWidget {

  final Function(int) onChange;
  LoginEnployee({Key? key, required this.onChange}) : super(key: key);

  @override
  State<LoginEnployee> createState() => _LoginEnployeeState();
}

class _LoginEnployeeState extends State<LoginEnployee> {
  @override
  late Future<Employee> futureTasjGet;
  bool info = true;

  String errorFoot = "User not found";

  List widgets = [];

  final TextEditingController _controller = TextEditingController();

  void searchEmployee(int id) async {
    setState(() {
      info = true;
    });
    final response = await get(Uri.parse('http://dummy.restapiexample.com/api/v1/employee/$id'));

    if (response.statusCode == 200) {
  
       final body = jsonDecode(response.body);
      var bodys = body['data'];
   
      if(bodys!=null){  
        info = true; 
        widget.onChange(2);
      } else {
        setState(() { info = false; });  
      }
    } else {
      setState(() { info = false; });
      
      throw "Unable to retrieve employee.";
    } 
  }
  @override
  void initState() {
    info = true; 
    print("info $info");
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) {
    final employee = Provider.of<AdminProv>(context, listen: false);
    return Scaffold(
      backgroundColor: Colors.indigo,
      body:  Center(
        child: ListView(
          children: [
            Column(
              children: [
                SizedBox(
                  height: 50,
                ),
                Container(
                  height: MediaQuery.of(context).size.height / 3,
                  width: double.infinity / 3,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(imgAndorid),
                      fit: BoxFit.contain
                    ),
                  ),
                ),
                const SizedBox(
                  height: 50,
                ),
                Container(
                  child: Text(
                    'Enter your user id',
                    style: TextStyle(
                      color: Colors.white70
                    ),
                  )
                ),
                Container(
                  width: 300,
                  margin: EdgeInsets.all(15),
                  child: TextField(
                    decoration: const InputDecoration(
                      filled: true,
                      fillColor: Color.fromARGB(255, 241, 241, 241),
                      border: OutlineInputBorder(),
                      labelText: "Id",
                      floatingLabelBehavior: FloatingLabelBehavior.auto,
                      hintStyle: TextStyle(
                        color: Color.fromARGB(255, 64, 179, 255)
                      ),
                      labelStyle: TextStyle(
                        color: Color.fromARGB(134, 14, 14, 14)
                      ),
                    ),
                    controller: _controller,
                  )
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    primary: Colors.white,
                    backgroundColor: Colors.teal,
                    onSurface: Colors.grey,
                  ),
                  onPressed: () {
                    employee.changesOption(int.parse(_controller.text));
                    searchEmployee(int.parse(_controller.text));
                  },
                  child: Text('Login'),
                ),
                info ? Container() : Container(child: Text("User not found" ,style: TextStyle(color: Colors.white70),))
              ],
            ),
          ],
        ),
      )
    );
  }
}
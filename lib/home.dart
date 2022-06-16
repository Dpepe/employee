import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_employee/provide_employee.dart';
import 'package:flutter_employee/employee/model.dart';

class Admin extends StatelessWidget {
  const Admin({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final employee = context.watch<AdminProv>().idAdmin;
    return DetailScreen(ids: employee);
  }
}

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.ids}) : super(key: key);
  final int ids;

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {

  late Future<Employee>? futureTasjGet;
  @override
  void initState() {
    super.initState();
    futureTasjGet = fetchEmployeeGet(widget.ids);
  }
  @override
  Widget build(BuildContext context) {
  
    return Scaffold(
      
      body: FutureBuilder<Employee>(
        future: futureTasjGet,
       
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return  Center(
              child:  Text("Ocurred faild")
            );
          } else if (snapshot.hasData) {
             // return Text('sdas');
            return  Center(
              child: Column(
                children: [
                  const TextDetail(employees:  "Bienvenido administrador"),
                  TextDetail(employees:  snapshot.data!.employee_age.toString()),
                  TextDetail(employees:  snapshot.data!.employee_name),
                  TextDetail(
                    employees: snapshot.data!.employee_salary.toString()),
                ],
              ),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ) 
    );
  }
}


class TextDetail extends StatelessWidget {
  const TextDetail({
    Key? key,
    required this.employees,
  }) : super(key: key);

  final String employees;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const  EdgeInsets.all(15),
      child: Text(
        employees,
        style: const TextStyle(
          fontSize: 20,
          color: Colors.black54,
        ),
      ));
  }
}
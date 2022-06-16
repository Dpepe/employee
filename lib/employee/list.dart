import 'package:flutter/material.dart';

import 'package:flutter_employee/employee/model.dart';
import 'package:flutter_employee/employee/datails.dart';


class ListEmloyee extends StatefulWidget {
  ListEmloyee({Key? key}) : super(key: key);

  @override
  State<ListEmloyee> createState() => _ListEmloyeeState();
}

class _ListEmloyeeState extends State<ListEmloyee> {
  @override

  late Future<List<Employee>> futureEmployeList;

  void onload(){
    setState(() {
      futureEmployeList = fetchEmployee();
    });
  }

  void initState() {
    futureEmployeList = fetchEmployee();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return  
      Scaffold(
        appBar: AppBar(
          title: Text(
            "List employee"
          ),
        ),
        body: FutureBuilder<List<Employee>>(
          future: fetchEmployee(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              print(snapshot.error);
              return  Center(
                child: Column(
                  children: [
                    Text('An error has occurred!' ),
                    Text('Recarge de nuevo la pagina!' ),
                    GestureDetector(
                      child: Icon(
                        Icons.autorenew
                      ),
                      onTap: (){
                        onload();
                      },
                    )
                  ],
                ),
              );
            } else if (snapshot.hasData) {
              return EmployeeList(employees: snapshot.data!);
            } else {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
  }
}

class EmployeeList extends StatelessWidget {
  const EmployeeList({Key? key, required this.employees}) : super(key: key);

  final List<Employee> employees;

  @override
  Widget build(BuildContext context) {
    //createAlbum("Sentadillas");
    return Center(
      child: Container(
        width: 350,
        child: ListView.builder(
          itemCount: employees.length,
          itemBuilder: (context, index) {
            var employee_salary = employees[index].employee_salary;
            var employee_name = employees[index].employee_name;
            var employee_age = employees[index].employee_age;
            var id = employees[index].id;
            return Center(
              child: Container(
                width: 300,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(5),
                  border: Border.all(
                    color: Color.fromARGB(255, 255, 255, 255),
                    width: 1
                  ),
                ),
                
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {
                      return   DetailScreen(heroTag: 'imageHero$index', ids:id );
                      }));
                    }, 
                    child: ListTile(
                      title: textStyleList(id.toString()),
                      subtitle:  textStyleList(employee_name),
                      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Hero(
                            tag: 'imageHero$index',
                            child: Text(
                              employee_salary.toString(),
                              style: TextStyle(
                                color: employee_salary > 132000  ? Color.fromARGB(255, 78, 76, 175) : Color.fromARGB(255, 13, 180, 221) 
                              ),
                            )
                          ),
                          Text(
                            employee_age.toString(),
                            style: TextStyle(
                              color: employee_age > 25 && employee_age < 35 ? Colors.green : Colors.red 
                            ),
                          )
                        ],
                      )
                    ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Text textStyleList(String employee_name) {
    return 
    Text(
      employee_name,
      style: const TextStyle(
        color: Color.fromARGB(255, 78, 78, 78)
      ),
    );
  }
}
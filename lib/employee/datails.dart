

import 'package:flutter/material.dart';
import 'package:flutter_employee/employee/model.dart';

class DetailScreen extends StatefulWidget {
  DetailScreen({Key? key, required this.heroTag, required this.ids}) : super(key: key);

  final String heroTag;
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
      appBar: AppBar(
        title: Text('Details'),
      ),
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
                  TextDetail(employees:  snapshot.data!.employee_age.toString()),
                  TextDetail(employees:  snapshot.data!.employee_name),
                  Hero(
                    tag: widget.heroTag,
                    child:   TextDetail(
                      employees: snapshot.data!.employee_salary.toString()),
                  ),
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
      margin: EdgeInsets.all(15),
      child: Text(
        employees,
        style: TextStyle(
          fontSize: 20,
          color: Colors.black54,
        ),
      ));
  }
}
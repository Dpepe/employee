import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_employee/employee/list.dart';
import 'package:flutter_employee/home.dart';
import 'package:flutter_employee/settings.dart';
import 'background.dart';
import 'login.dart';
import 'dart:async';
import 'package:provider/provider.dart';
import 'provide_employee.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
 
        primarySwatch: Colors.blue,
      ),
      home:  IndexEmployee(),
    );
  }
}

class IndexEmployee extends StatefulWidget {
  IndexEmployee({Key? key}) : super(key: key);
  @override
  State<IndexEmployee> createState() => _IndexEmployeeState();
}

class _IndexEmployeeState extends State<IndexEmployee> {
  int indexSelect = 0;
  int ids_admin = 0;
  
  @override
  void initState(){
    indexSelect = 0;
    
    Future.delayed(const Duration(milliseconds: 3000), (){
      setState(() {
        indexSelect = 1;
      });
    }); 
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: Duration(milliseconds: 250),
      switchInCurve: Curves.elasticOut,
      switchOutCurve: Curves.easeOut,
      transitionBuilder: (Widget child, Animation<double> animation,){
        return ScaleTransition(scale: animation, child: child,);
      },
      child: getPage(this.indexSelect)
    );
    
  }
  getPage(int page){
    switch(page){
      case 0:
        return BackgroundMainEnployee();
      case 1:
        return
        ChangeNotifierProvider<AdminProv>(
        create: (_)=> AdminProv(),
        child: 
          LoginEnployee(
            onChange: (index) => setState(() {indexSelect = index;})
          )
        );
      case 2:
        return  ChangeNotifierProvider<AdminProv>(
        create: (_)=> AdminProv(),
        child: 
          MyPageEmployee(
            onChange: (index) => setState(() {indexSelect = index;})
          )
        );
    }
  }
}

class MyPageEmployee extends StatefulWidget {

  final Function(int) onChange;
  MyPageEmployee({Key? key, required this.onChange}) : super(key: key);

  @override
  State<MyPageEmployee> createState() => _MyPageEmployeeState();
}

class _MyPageEmployeeState extends State<MyPageEmployee> {
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      appBar: AppBar(
        title: Text("Home employee"),
        actions: [
          Icon(
            Icons.search,
          ),
          Icon(
            Icons.more_vert,
          )
        ],
      ),
      body: Admin(),
      drawer: Drawer(
        child: ListView(
          children: [
             DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
              ),
              child: CircleAvatar(
                child: Image.file(File("/data/user/0/com.example.projectname/app_flutter/android_rob.jpg")),
              ),
            ),
            ListTile(
              title: Text("Settings"),
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return   Settings();
                }));
              }, 
            ),
            ListTile(
              title: Text("Employee"),
               onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return   ListEmloyee();
                }));
              }, 
            ),
            ListTile(
              title: Text("Close"),
               onTap: () {
                widget.onChange(1);
              }, 
            )
          ],
        ),
      ),
    );
  }
}
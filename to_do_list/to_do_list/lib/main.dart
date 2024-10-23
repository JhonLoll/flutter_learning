// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
//Importing home page package
import 'package:to_do_list/pages/to_do_list_home.dart';

void main(){
  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ToDoList(),
    );
  }
}
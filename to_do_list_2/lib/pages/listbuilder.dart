// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {

  final TextEditingController listController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: listController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: ("Adicionar tarefa")
                      ),
                    ),
                  ),
                  SizedBox(width: 8,),
                  ElevatedButton(
                    onPressed: (){}, 
                    child: Icon(Icons.add, size: 30,)
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
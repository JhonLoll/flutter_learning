// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables
import 'dart:ffi';

import 'package:flutter/material.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});

  @override
  State<ToDoList> createState() => _ToDoList();
}

class _ToDoList extends State<ToDoList> {
  final TextEditingController listController = TextEditingController();

  List<String> lista = [];

  var quantidadeTarefas = 0;

  void deleteItem(int index){
    lista.remove(index);
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(children: [
                Expanded(
                    child: TextField(
                  controller: listController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: ('Adicione uma tarefa'),
                  ),
                )),
                SizedBox(
                  width: 8,
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey,
                      padding: EdgeInsets.all(14)),
                  onPressed: () {
                    setState(() {
                      lista.add(listController.text);
                      listController.clear();
                      quantidadeTarefas = quantidadeTarefas + 1;
                    });
                  },
                  child: Icon(
                    Icons.add,
                    size: 24,
                    color: Colors.white,
                  ),
                ),
              ]),
              SizedBox(
                height: 12,
              ),
              ListView(shrinkWrap: true, children: [
                for (String itens in lista)
                  ListTile(
                    title: Text(itens),
                    subtitle: Text('Outubro'),
                    leading: Icon(
                      Icons.access_time,
                      size: 30,
                    ),
                    trailing: ElevatedButton(
                      child: Icon(
                        Icons.delete,
                        size: 30,
                      ),
                      onPressed: () {
                        deleteItem(index)
                      },
                    ),
                    onTap: () {},
                  ),
              ]),
              SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: Text(
                          '${quantidadeTarefas} tarefas a serem concluídas')),
                  SizedBox(
                    width: 8,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        setState(() {
                          lista.clear();
                          quantidadeTarefas = 0;
                        });
                      },
                      child: Text('Limpar tudo'))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

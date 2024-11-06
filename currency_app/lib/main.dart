import 'package:flutter/material.dart';
import 'dart:async'; //Faz requisição assincrona
import 'dart:convert'; //Converte a requisição em JSON
import 'package:http/http.dart' as http; //Realiza as requisições em HTTP

const request = "https://api.hgbrasil.com/finance?key=245b5443";

void main() async {
  print(await getData());

  runApp(const MaterialApp(
    debugShowCheckedModeBanner: false,
    home: Conversor(),
  ));
}

Future<Map> getData() async {
  http.Response response = await http.get(Uri.parse(request));
  return (json.decode(response.body));
}

class Conversor extends StatefulWidget {
  const Conversor({super.key});

  @override
  State<Conversor> createState() => _ConversorState();
}

class _ConversorState extends State<Conversor> {
  //Inicializa uma variavel da seleção da currency
  String currency = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          "CONVERSOR - BRL to $currency",
          style: const TextStyle(color: Colors.white),
        ),
        leading:
            const Icon(Icons.monetization_on_outlined, color: Colors.white),
        backgroundColor: Colors.indigo[800],
        centerTitle: true,
        actions: [
          Icon(
            Icons.refresh,
            color: Colors.white,
          )
        ],
      ),
      body: FutureBuilder<Map>(
        future: getData(),
        builder: (context, snapshot) {
          switch (snapshot.connectionState){
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                child: Text("Carregando...", style: TextStyle(color: Colors.brown[900]),),

              );
            case ConnectionState.active:
              return Center(
                child: Text("Carregamento concluído.", style: TextStyle(color: Colors.green[400]),),
              );
            case ConnectionState.done:
              return Center(
                child: Text("Dados:", style: TextStyle(color: Colors.black),),
              );
          }
        },
      ),
    );
  }
}

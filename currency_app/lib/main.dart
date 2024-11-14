// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

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
  //Inicializa uma variavel para armazenar resultados de erros
  String errorCatch = "";
  //Inicializa a lista dos itens
  List<String> listCurrencies = [
    'USD',
    'EUR',
    'BTC',
  ];

  //Inicializa uma variável de seleção inicial do drpdown
  String? defaultSelection;

  //Inicializa os controllers de cada campo de textfield
  final brlController = TextEditingController();
  final convertController = TextEditingController();

  //Funções que alteram o valor convertido a cada alteração
  void convertCurrency(double currencyValue) {
    setState(() {
      try {
        var brlconvert = double.parse(brlController.text);
        if (brlconvert <= 0) {
          errorCatch = "Por favor, informe um valor maior que zero";
          return;
        }

        var valueConvert = double.parse(brlController.text) / currencyValue;
        convertController.text = valueConvert.toStringAsFixed(2);
      } catch (e) {
        errorCatch = "Erro ao converter os valores";
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          "CONVERSOR - BRL to $defaultSelection",
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
          switch (snapshot.connectionState) {
            case ConnectionState.none:
            case ConnectionState.waiting:
              return Center(
                  child: Column(
                children: [
                  Text(
                    "Carregando...",
                    style: TextStyle(color: Colors.brown[900]),
                  ),
                  const CircularProgressIndicator()
                ],
              ));
            case ConnectionState.active:
              return Center(
                child: Text(
                  "Carregamento concluído.",
                  style: TextStyle(color: Colors.green[400]),
                ),
              );
            case ConnectionState.done:
              return Center(
                child: Column(children: [
                  SizedBox(
                    height: 80,
                  ),
                  DropdownButton(
                    hint: Text("Selecione:"),
                    value: defaultSelection,
                    onChanged: (newValue) {
                      setState(() {
                        defaultSelection = newValue;
                        convertCurrency(snapshot.data!['results']['currencies']
                            ['$defaultSelection']['sell']);
                      });
                    },
                    items: listCurrencies.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  Divider(),
                  TextField(
                    controller: brlController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: 'R\$'),
                    onChanged: (_) => convertCurrency(snapshot.data!['results']
                        ['currencies']['$defaultSelection']['sell']),
                  ),
                  Divider(),
                  TextField(
                    controller: convertController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: defaultSelection),
                  )
                ]),
              );
          }
        },
      ),
    );
  }
}

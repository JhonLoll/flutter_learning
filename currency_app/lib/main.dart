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
  List<String> listCurrencies = ['USD', 'EUR', 'BTC', 'BRL'];

  //Inicializa uma variável de seleção inicial do drpdown
  String? convert1;
  String? convert2;
  //Inicializa a variavel de hint text dos textfield
  String? hintText1;
  String? hintText2;

  void transformHintText() {
    switch (convert1) {
      case "BRL":
        setState(() {
          hintText1 = "R\$";
        });
      case "USD":
        setState(() {
          hintText1 = "\$";
        });
        break;
      case "EUR":
        setState(() {
          hintText1 = "€";
        });
      case "BTC":
        setState(() {
          hintText1 = "BTC";
        });
        break;
      default:
    }
    switch (convert2) {
      case "BRL":
        setState(() {
          hintText2 = "R\$";
        });
      case "USD":
        setState(() {
          hintText2 = "\$";
        });
        break;
      case "EUR":
        setState(() {
          hintText2 = "€";
        });
      case "BTC":
        setState(() {
          hintText2 = "BTC";
        });
        break;
      default:
    }
  }

  //Inicializa os controllers de cada campo de textfield
  final brlController = TextEditingController();
  final convertController = TextEditingController();

  //Funções que alteram o valor convertido a cada alteração
  void convertCurrency(double currencyValue1, double currencyValue2) {
    setState(() {
      var value1 = double.parse(brlController.text);

      value1 = currencyValue1 * value1;
      var valueConverted = value1 / currencyValue2;
      convertController.text = valueConverted.toStringAsFixed(2);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          "CONVERSOR - $convert1 to $convert2",
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
                    value: convert1,
                    onChanged: (newValue) {
                      setState(() {
                        convert1 = newValue;
                        transformHintText();
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
                        border: OutlineInputBorder(), hintText: hintText1),
                    onChanged: (_) => convertCurrency(
                        snapshot.data!['results']['currencies']['$convert1']
                            ['sell'],
                        snapshot.data!['results']['currencies']['$convert2']
                            ['sell']),
                  ),
                  Divider(),
                  DropdownButton(
                    hint: Text("Selecione:"),
                    value: convert2,
                    onChanged: (newValue) {
                      setState(() {
                        convert2 = newValue;
                        transformHintText();
                      });
                    },
                    items: listCurrencies.map((location) {
                      return DropdownMenuItem(
                        child: new Text(location),
                        value: location,
                      );
                    }).toList(),
                  ),
                  TextField(
                    controller: convertController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(), hintText: hintText2),
                  )
                ]),
              );
          }
        },
      ),
    );
  }
}

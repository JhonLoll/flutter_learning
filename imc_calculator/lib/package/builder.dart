import 'package:flutter/material.dart';

class ImcBuilder extends StatefulWidget {
  const ImcBuilder({super.key});

  @override
  State<ImcBuilder> createState() => _ImcBuilderState();
}

class _ImcBuilderState extends State<ImcBuilder> {
  final TextEditingController textPeso = TextEditingController();
  final TextEditingController textAltura = TextEditingController();
  double pesoIdeal = 0;
  String textView = "Informe seus dados!";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            //mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Expanded(
                      child: AppBar(
                    title: const Text("Calculadora de IMC"),
                    centerTitle: false,
                    leading: const Icon(
                      Icons.calculate,
                      size: 30,
                    ),
                    actions: [
                      IconButton(
                          onPressed: clearContent,
                          icon: const Icon(
                            Icons.cleaning_services_rounded,
                            size: 30,
                          ))
                    ],
                  ))
                ],
              ),
              const SizedBox(
                height: 200,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: textPeso,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: "Peso (KG)"),
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: TextField(
                    controller: textAltura,
                    decoration: InputDecoration(
                        border: UnderlineInputBorder(
                            borderRadius: BorderRadius.circular(30)),
                        labelText: "Altura (cm)"),
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  Expanded(
                      child: ElevatedButton(
                        onPressed: calculateIMC,
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.lightBlue[100],
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(50)))),
                        child: const Text(
                          "Calcular",
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                  ))
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Text(pesoIdeal == 0 ? "Informe seus dados!" : "Peso ideal $pesoIdeal")
            ],
          ),
        ),
      ),
    );
  }
  void calculateIMC(){
    setState(() {
      try {
        var peso = double.parse(textPeso.text);
        var altura = double.parse(textAltura.text);

        if (peso <= 0 || altura <= 0) {
          textView = "Dados inválidos";
          return;
        }

        pesoIdeal = peso / ((altura/100) * (altura/100));
        var pesoIdealFormated = pesoIdeal.toStringAsFixed(2);
        textView = "Peso ideal: ${pesoIdealFormated} kg";
      } catch (e) {
        textView = "Erro ao converter os valores: $e";
      }
    });
  }
  void clearContent(){
    setState(() {
      textAltura.clear();
      textPeso.clear();
      textView = "Informe seus dados!";
    });
  }
}

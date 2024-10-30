// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:imc_calculator/package/builder.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ImcBuilder(),
    );
  }
}
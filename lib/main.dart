import 'package:flutter/material.dart';
import 'package:flutter_with_sqflite_demo/screens/list_product.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Flutter Demo',
      home:ListProduct(),
    );
  }
}

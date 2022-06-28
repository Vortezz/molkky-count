import 'package:flutter/material.dart';
import 'package:molkkycount/class/client.dart';
import 'package:molkkycount/pages/home.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'molkkyCount',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(
        client: Client(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

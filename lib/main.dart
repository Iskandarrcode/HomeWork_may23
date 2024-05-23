import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:may23/mashq_1.dart';
import 'package:may23/mashq_2.dart';
import 'package:may23/mashq_3.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PageView(
        children: const [
           ListScreen(),
           ComputationScreen(),
           ImageScreen(),
        ],
      ),
    );
  }
}

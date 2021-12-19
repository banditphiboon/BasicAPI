import 'package:flutter/material.dart';
import 'package:layout/page/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  //const MyApp({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Medical Divice",
      home: HomePage(),
    );
  }
}
import 'package:flutter/material.dart';
import 'todo_screen.dart';

void main() {
  runApp(MyApp());
}
class MyApp extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: "Store Duck Management",
      home: TodoScreen(),
    );

  }
  
}



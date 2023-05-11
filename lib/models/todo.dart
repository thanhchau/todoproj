import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoprj/global.dart';
import 'task.dart';
class Todo{
  int id;
  String name;
  String priority;
  String description;
  String duedate;
  List<Task> tasks = <Task>[];

  Todo({required this.id,required this.name,required this.priority,required this.duedate,required this.description});
  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
        id: json["id"],
        name: json["name"],
        priority: json["priority"].toString(),
        duedate: json["duedate"],
        description: json["description"]
    );
  }
  //Fetch data from Restful API

}
Future<List<Todo>> fetchTodos(http.Client client) async{
  final response = await client.get(Uri.parse(URL_TODOS));
  print(response);
  if(response.statusCode == 200){
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final todos = mapResponse["data"].cast<Map<String, dynamic>>();

    final listOfTodos = await todos.map<Todo>((json) {
      return Todo.fromJson(json);
    }).toList();
    return listOfTodos;
  }else{
    throw Exception('Failed to load Todo from the Internet');
  }
}

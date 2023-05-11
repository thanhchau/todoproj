import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoprj/global.dart';
import 'package:todoprj/models/todo.dart';
import 'task.dart';
class Todo{
  int id;
  String name;
  String priority;
  String description;
  String duedate;
  List<Task> tasks = <Task>[];

  Todo({required this.id,required this.name,required this.priority,required this.duedate,required this.description,required this.tasks});
  factory Todo.fromJson(Map<String, dynamic> json){
    return Todo(
        id: json["id"],
        name: json["name"],
        priority: json["priority"].toString(),
        duedate: json["duedate"],
        description: json["description"],
        tasks: convertToTaskList(json["tasks"].cast<Map<String, dynamic>>())
    );
  }
  Map<String, dynamic> toJson(Todo todo){
    return {
      'id' : todo.id,
      'name': todo.name,
      'priority': todo.priority,
       'duedate':todo.duedate,
       'description':todo.description,
        'tasks': jsonEncode(todo.tasks.map((t) => t.toJson(t)).toList())
    };
  }

  //Fetch data from Restful API

}

List<Task> convertToTaskList(dynamic tasks){

  return tasks.map<Task>((json){
    return Task.fromJson(json);
  }).toList();
}
Future<List<Todo>> fetchTodos(http.Client client) async{
  final response = await client.get(Uri.parse(URL_TODOS));
  if(response.statusCode == 200){
    Map<String, dynamic> mapResponse = json.decode(response.body);
    final todos = mapResponse["data"].cast<Map<String, dynamic>>();
    final listOfTodos = await todos.map<Todo>((json) {
      return Todo.fromJson(json);
    }).toList();
    Todo todo3 = listOfTodos[3];
    print(todo3.tasks[0].name);
    return listOfTodos;
  }else{
    throw Exception('Failed to load Todo from the Internet');
  }
}

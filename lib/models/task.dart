import 'package:flutter/material.dart';
class Task{
  int id;
  String name;
  bool isfinished;
  Task({required this.id,required this.name,required this.isfinished});
  factory Task.fromJson(Map<String, dynamic> json){
    return Task(
        id: json["id"],
        name: json["name"],
        isfinished: json["isfinished"].toString().toLowerCase() == "true"

    );
  }
  Map<String, dynamic> toJson(Task task){
    return {
      'id' : task.id,
      'name': task.name,
      'isfinished': "true"
    };
  }

}
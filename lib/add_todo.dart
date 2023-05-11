import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:todoprj/models/todo.dart';
import 'todo_screen.dart';
import 'dart:convert' as convert;
import 'global.dart';
class AddTodoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return AddToDoState();
  }

}
class AddToDoState extends State<AddTodoScreen>{
  Todo todo = new Todo(id: 0, name: "", priority: "", duedate: "", description: "");
  final nameController = new TextEditingController();
  final priorityController = new TextEditingController();
  final descriptionController = new TextEditingController();
  final duedateController = new TextEditingController();
  Future save() async {
    // var jsonResponse = null;
    print(todo.name);

    Map<String, dynamic> jsonMap = {
      'data': {
        'name':todo.name,
        'priority': todo.priority,
        'description': todo.description,
        'duedate':'2023-01-04'
      }
    };


   await http.post(Uri.parse(URL_TODOS,),
       headers:<String, String> {
         'Content-Type': 'application/json; charset=UTF-8',
       },
       body:convert.jsonEncode(jsonMap),
    ).then((http.Response response){
        print("Response status: ${response.statusCode}");
        print("Response body: ${response.contentLength}");
        print(response.body);
        print(response.request.toString());
    });
    //print(jsonResponse.body);
    Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => TodoScreen()), (Route<dynamic> route) => false);
  }
  InputDecoration makeInput(String hinttext){
    return InputDecoration(
        labelText: hinttext,
        //hintText:  hinttext,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          borderSide: BorderSide(
              width: 1.5, color: Colors.lightBlueAccent), //<-- SEE HERE
        )
    );
  }
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Add New ToDo"),
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: nameController,
                onChanged: (text){
                  todo.name = text;
                },
                decoration: makeInput("Input Your name"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: priorityController,
                onChanged: (text){
                  todo.priority = text;
                },
                decoration: makeInput("Input Priority"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: descriptionController,
                onChanged: (text){
                  todo.description = text;
                },
                decoration: makeInput("input Description"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: duedateController,
                onChanged: (text){
                  todo.duedate = text;
                },
                decoration: makeInput("input DueDate"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: TextButton(
                    style: TextButton.styleFrom(
                        backgroundColor: Colors.lightBlue,
                        foregroundColor: Colors.white,

                    ),
                    onPressed:save,
                    child: Text('Save Data',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                ),
              ),
            )
          ],
        ),
      ),
    );

  }

}
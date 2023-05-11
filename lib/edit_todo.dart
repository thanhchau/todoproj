import 'package:flutter/material.dart';
import 'package:todoprj/global.dart';
import 'package:todoprj/models/todo.dart';
import 'package:http/http.dart' as http;
import 'package:todoprj/todo_screen.dart';
import 'dart:convert' as convert;
class EditTodoScreeen extends StatefulWidget{
  final Todo todo;
  EditTodoScreeen({required this.todo});
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return EditToDoState();
  }

}

class EditToDoState extends State<EditTodoScreeen>{
  //Edit Todo
  Future editTodo({required Todo todo, required String name, required String priority, required String description, required String duedate}) async {
    String url ="$URL_TODOS/${todo.id}";

    Map<String, dynamic> jsonMap = {
      'data': {
        'name':name,
        'priority': priority,
        'description': description,
        'duedate':'2023-01-01'
      }
    };
    print(convert.jsonEncode(jsonMap));

        // await http.put(Uri.parse(url,),
        //   headers:<String, String> {
        //     'Content-Type': 'application/json; charset=UTF-8',
        //   },
        //   body:convert.jsonEncode(jsonMap),
        // ).then((http.Response response){
        //   print("Response status: ${response.statusCode}");
        //   print("Response body: ${response.contentLength}");
        //   print(response.body);
        //   print(response.request.toString());
        // });

    final response = await http.put(Uri.parse(url,),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: convert.jsonEncode(jsonMap));
    if (response.statusCode == 200) {
      print(response.reasonPhrase);
      Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (BuildContext context) => TodoScreen()),(Route<dynamic> route) => false);
    } else {
      print(response.statusCode);
      print(response.body);
    }
  }
  //Delete ToDo
  Future deleteTodo({required Todo todo}) async{
    String url ="$URL_TODOS/${todo.id}";
    await http.delete(Uri.parse(url));
    Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (BuildContext context) => TodoScreen()),
            (Route<dynamic> route) => false);
  }
  void _onButtonShowModalSheet({required Todo todo}){
    showModalBottomSheet(
        context: context,
        builder: (context){
          return Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Container(
                padding: EdgeInsets.all(10),
                child: Text(
                    "Are you Sure Want To Delete Item",
                    style: TextStyle(
                      fontSize: 25,
                      
                      fontWeight: FontWeight.bold,
                      color: Colors.redAccent
                    ),

                )
              ),
              Container(
                child: Text("To do Name "+todo.name+", To do Id "+todo.id.toString())
              ),
              Padding(
                  padding: EdgeInsets.all(10)
              )
              ,
              Container(
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(

                    style : ElevatedButton.styleFrom(
                      backgroundColor: Colors.redAccent,

                    ),
                    child: Text('Delete Item ', style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: () {
                        this.deleteTodo(todo: todo);

                    },
                  ),
                ),
              ),
              Padding(
                  padding: EdgeInsets.all(10)
              )
              ,
              Container(
                child: SizedBox(
                  height: 50,
                  width: 200,
                  child: ElevatedButton(

                    style : ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal,

                    ),
                    child: Text('Cancel  ', style: TextStyle(fontSize: 20, color: Colors.white),),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
              )


            ],
          );

        }
    );
  }
  //Make Input Decoration
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
    final nameController = TextEditingController(text: widget.todo.name);
    final priorityController = TextEditingController(text: widget.todo.priority);
    final descriptionController = new TextEditingController(text: widget.todo.description);
    final duedateController = new TextEditingController(text: widget.todo.duedate);
    String _name = widget.todo.name ;
    String _priority= widget.todo.priority;
    String _description =  widget.todo.description ;
    String _duedate =  widget.todo.description;


    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("Edit Detail of Gesture"),
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
                  _name = text;
                },
                decoration: makeInput("Input Your name"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: priorityController,
                onChanged: (text){
                  _priority = text;
                },
                decoration: makeInput("Input Priority"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: descriptionController,
                onChanged: (text){
                  _description = text;
                },
                decoration: makeInput("input Description"),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: TextField(
                controller: duedateController,
                onChanged: (text){
                  _duedate = text;
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
                    onPressed:(){
                      editTodo(
                          todo: widget.todo,
                          name: _name,
                          priority: _priority,
                          description: _description,
                          duedate: _duedate
                      );
                    },
                    child: Text('Save Data',
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    )
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.all(10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,

                    ),
                    onPressed:(){
                      // deleteTodo(
                      //   todo: widget.todo
                      // );
                      this._onButtonShowModalSheet(todo: widget.todo);
                    },
                    child: Text('Delete Data',
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

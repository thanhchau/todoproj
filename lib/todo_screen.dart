import 'package:flutter/material.dart';
import 'package:todoprj/edit_todo.dart';

import 'package:http/http.dart' as http;
import 'add_todo.dart';
import 'models/todo_model.dart';

class TodoScreen extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return TodoState();
  }

}

class TodoState extends State<TodoScreen>{
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
     return Scaffold(
       appBar: AppBar(
         title: Text('Ticket tour Management'),
         actions:<Widget>[
           IconButton(
               onPressed: (){
                 //Press To Add New Todo
                 Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => AddTodoScreen()), (Route<dynamic> route) => true);
               },
               icon: Icon(Icons.add)
           )
         ],
       ),
       body: FutureBuilder(
         future: fetchTodos(http.Client()),
         builder: (context, snapshot){
           if(snapshot.hasError) {
             print(snapshot.error);
           }
           return snapshot.hasData ? TodoList(todos: snapshot.data as List<Todo>):Center(child: CircularProgressIndicator());
         },
       ),
     );
  }

}
class TodoList extends StatelessWidget{
  List<Todo> todos;
  TodoList({Key? key, required this.todos}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index){
          return GestureDetector(
            onTap: (){
             // Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (BuildContext context) => EditTodoScreeen(todo: todos[index])), (Route<dynamic> route) => true);
            },
            child: Container(
              padding: EdgeInsets.all(5),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: index % 2 ==0 ? Colors.greenAccent : Colors.cyan,
                ),
                padding: EdgeInsets.all(10.0),

                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    new Text(todos[index].id.toString() , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                    new Text(todos[index].name , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                    new Text("Priority "+todos[index].priority , style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0)),
                    new Text('Date: ${todos[index].duedate}', style: TextStyle(fontSize: 16.0),)
                  ],
                ),
              ),
            )
          );
        }
    );
  }

}
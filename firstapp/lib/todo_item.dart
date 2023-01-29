import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  const TodoItem({super.key, required this.todo});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          print("working!!!");
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: const Color.fromARGB(236, 250, 250, 28),
        leading: const Icon(
          Icons.check_box_outline_blank_outlined,
          color: Color.fromARGB(206, 20, 20, 20),
        ),
        // ignore: prefer_const_constructors
        title: Text(
          todo.todoText!,
          style: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.w500,
            decoration: todo.isDone ? TextDecoration.lineThrough : null,
          ),
        ),
        trailing: Container(
          height: 50,
          width: 40,
          /*decoration: BoxDecoration(
              color: Colors.red, borderRadius: BorderRadius.circular(5)),*/
          child: IconButton(
            color: Colors.red,
            iconSize: 30,
            icon: Icon(Icons.delete_outline),
            onPressed: () {
              print("clicked on delete");
            },
          ),
        ),
      ),
    );
  }
}

//models:--

class Todo {
  String? id;
  String? todoText;
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [
      Todo(id: "01", todoText: "exercise", isDone: true),
      Todo(id: "02", todoText: "face care", isDone: true),
      Todo(id: "03", todoText: "study"),
      Todo(id: "04", todoText: "college"),
      Todo(id: "05", todoText: "homework"),
      Todo(id: "06", todoText: "flutter"),
      Todo(id: "07", todoText: "perfectB"),
      Todo(id: "08", todoText: "dinner"),
    ];
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:hive/hive.dart';
part 'todo_item.g.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final ontodoChange;
  final onDeleteItem;
  const TodoItem(
      {super.key,
      required this.todo,
      required this.ontodoChange,
      required this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 20),
      child: ListTile(
        onTap: () {
          ontodoChange(todo);
        },
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        tileColor: const Color.fromARGB(236, 250, 250, 28),
        leading: Icon(
          todo.isDone
              ? Icons.check_box_outlined
              : Icons.check_box_outline_blank_outlined,
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
              onDeleteItem(todo.id);
            },
          ),
        ),
      ),
    );
  }
}

//models:--
@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String? id;
  @HiveField(1)
  String? todoText;
  @HiveField(2)
  bool isDone;

  Todo({
    required this.id,
    required this.todoText,
    this.isDone = false,
  });

  static List<Todo> todoList() {
    return [];
  }
}

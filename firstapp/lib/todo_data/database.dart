import 'package:firstapp/todo_item.dart';
import 'package:hive/hive.dart';

class Todo_database {
  List foundTodo = [];
  //reference the box
  final _todobox = Hive.box('todobox');
  //this method called when app is ran for first time ever:-
  void createIntialData() {
    foundTodo = [];
  }

  //load the data from database:-
  void loadData() {
    foundTodo = _todobox.get("TODOLIST");
  }

  //update database
  void updateDatabse() {
    _todobox.put("TODOLIST", foundTodo);
  }
}
